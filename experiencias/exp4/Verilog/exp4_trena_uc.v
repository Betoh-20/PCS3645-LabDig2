/* --------------------------------------------------------------------------
 *  Arquivo   : exp4_trena_uc.v
 * --------------------------------------------------------------------------
 *  Descricao : Unidade de Controle do circuito medicao de distancias e
 *              comunicacao serial
 *              
 * --------------------------------------------------------------------------
 *  Revisoes  :
 *      Data        Versao  Autor             Descricao
 *      19/09/2025  1.0     Andre Ito         versao inicial
 *                          Paulo Yamaguti
 *                          Roberto Hiraoka
 * --------------------------------------------------------------------------
 */
 
module exp4_trena_uc (
    input clock,
    input reset,
    input mensurar,
    input echo,
    output       trigger,
    output       saida_serial,
    output [6:0] medida0,
    output [6:0] medida1,
    output [6:0] medida2,
    output       pronto,
    output [6:0] db_estado
);

    // Tipos e sinais
    reg [2:0] Eatual, Eprox; // 3 bits são suficientes para 7 estados

    // Parâmetros para os estados
    parameter  inicial    = 3'b000;
    parameter  preparacao = 3'b001;
    parameter  medir      = 3'b010;
    parameter  transmitir = 3'b011;
    parameter  = 3'b100;
    parameter  = 3'b101;
    parameter  = 3'b110;

    // Estado
    always @(posedge clock, posedge reset) begin
        if (reset) 
            Eatual <= inicial;
        else
            Eatual <= Eprox; 
    end

    // Lógica de próximo estado
    always @(*) begin
        case (Eatual)
            inicial: Eprox <= mensurar ? preparacao : inicial;
            preparacao: Eprox <= medir;
            medir:      Eprox <= transmitir;
            transmitir: Eprox <= inicial;
            default: 
                Eprox = inicial;
        endcase
    end

    // Saídas de controle
    always @(*) begin
        case (Eatual)
            preparacao: zera = 1'b1;
            default:    zera = 1'b0;
        endcase
		  
		  case (Eatual)
				
		  endcase
		  
        case (Eatual)
            
            default:       db_estado = 4'b1110;
        endcase
    end

endmodule
