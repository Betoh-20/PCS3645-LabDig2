/* --------------------------------------------------------------------------
 *  Arquivo   : contador_cm_uc-PARCIAL.v
 * --------------------------------------------------------------------------
 *  Descricao : unidade de controle do componente contador_cm
 *              
 *              incrementa contagem de cm a cada sinal de tick enquanto
 *              o pulso de entrada permanece ativo
 *              
 * --------------------------------------------------------------------------
 *  Revisoes  :
 *      Data        Versao  Autor             Descricao
 *      07/09/2024  1.0     Edson Midorikawa  versao em Verilog
 *      14/09/2024  2.0     Andre Ito         preenchimento de estados
 *                          Paulo Yamaguti
 *                          Roberto Hiraoka
 * --------------------------------------------------------------------------
 */

module contador_cm_uc (
    input wire clock,
    input wire reset,
    input wire pulso,
    input wire tick,
	 input wire fim_tick,
    output reg zera_tick,
    output reg conta_tick,
    output reg zera_bcd,
    output reg conta_bcd,
    output reg pronto
);

    // Tipos e sinais
    reg [2:0] Eatual, Eprox; // 3 bits são suficientes para os estados

    // Parâmetros para os estados
	/* completar */
    parameter inicial         = 3'b000;
    parameter conta_tempo     = 3'b001;
    parameter conta_distancia = 3'b010;
    parameter zera_tempo      = 3'b011;
    parameter final = 3'b100;

    // Memória de estado
    always @(posedge clock, posedge reset) begin
        if (reset)
            Eatual <= inicial;
        else
            Eatual <= Eprox; 
    end

    // Lógica de próximo estado
    always @(*) begin
			case (Eatual)
				inicial:         Eprox <= pulso ? conta_tempo : inicial;
				conta_tempo:     Eprox <= pulso ? fim_tick    ? zera_tempo
																		    : tick  ? conta_distancia
																					   : conta_tempo
														  : final;
				conta_distancia: Eprox <= conta_tempo;
				zera_tempo:      Eprox <= conta_tempo;
				final:           Eprox <= inicial;
			endcase
    end

    // Lógica de saída (Moore)
    always @(*) begin
			case (Eatual)
            inicial: begin
					zera_tick  <= 1'b1;
					conta_tick <= 1'b0;
					zera_bcd   <= 1'b1;
					conta_bcd  <= 1'b0;
					pronto     <= 1'b0;
				end
				conta_tempo: begin
					zera_tick  <= 1'b0;
					conta_tick <= 1'b1;
					zera_bcd   <= 1'b0;
					conta_bcd  <= 1'b0;
					pronto     <= 1'b0;
				end
				conta_distancia: begin
					zera_tick  <= 1'b0;
					conta_tick <= 1'b1;
					zera_bcd   <= 1'b0;
					conta_bcd  <= 1'b1;
					pronto     <= 1'b0;
				end
				zera_tempo: begin
					zera_tick  <= 1'b1;
					conta_tick <= 1'b0;
					zera_bcd   <= 1'b0;
					conta_bcd  <= 1'b0;
					pronto     <= 1'b0;
				end
				final: begin
					zera_tick  <= 1'b0;
					conta_tick <= 1'b0;
					zera_bcd   <= 1'b0;
					conta_bcd  <= 1'b0;
					pronto     <= 1'b1;
				end
        endcase
    end

endmodule