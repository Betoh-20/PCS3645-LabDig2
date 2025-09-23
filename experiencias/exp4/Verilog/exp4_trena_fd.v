/* --------------------------------------------------------------------------
 *  Arquivo   : exp4_trena_fd.v
 * --------------------------------------------------------------------------
 *  Descricao : Fluxo de dados do circuito medicao de distancias e
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
 
module exp4_trena_fd (
    input       clock,
    input       reset,
    input       mensurar,
    input       echo,
    input [1:0] seletor_dado,
    output       trigger,
    output       saida_serial,
    output [6:0] medida0,
    output [6:0] medida1,
    output [6:0] medida2,
    output       pronto
);

    // Sinais internos
    wire [6:0] s_medida, s_medida0, s_medida1, s_medida2;

    interface_hcsr04 Sensor_de_Distancia (
        .clock     (clock                              ),
        .reset     (reset                              ),
        .medir     (mensurar                           ),
        .echo      (echo                               ),
        .trigger   (trigger                            ),
        .medida    ({ s_medida2, s_medida1, s_medida0 }),
        .pronto    (pronto                             )
    );

    // Multiplexador de dados digitais -> seriais
    assign s_medida = seletor_dado[1] ? s_medida2
                                      : seletor_dado[0] ? s_medida1
                                                        : s_medida0;

    tx_serial_7E1 Transmissor_Serial (
        .clock        (clock),
        .reset        (reset),
        .partida      (partida),
        .dados_ascii  (s_medida),
        .saida_serial (saida_serial),
        .pronto       (pronto)
    );


endmodule
