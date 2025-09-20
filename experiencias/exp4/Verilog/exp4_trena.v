/* --------------------------------------------------------------------------
 *  Arquivo   : exp4_trena.v
 * --------------------------------------------------------------------------
 *  Descricao : circuito de trena digital com comunicação serial
 *              
 * --------------------------------------------------------------------------
 *  Revisoes  :
 *      Data        Versao  Autor             Descricao
 *      19/09/2025  1.0     Roberto Hiraoka   Inicial
 * --------------------------------------------------------------------------
 */

module exp4_trena (
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

    // Sinais internos
    wire s_mensurar;

    edge_detector EdgeDetector (
        .clock (clock     ),
        .reset (reset     ),
        .sinal (mensurar  ),
        .pulso (s_mensurar)
    );
    
    interface_hcsr04 SensorDeDistancia (
        .clock     (clock                        ),
        .reset     (reset                        ),
        .medir     (s_mensurar                   ),
        .echo      (echo                         ),
        .trigger   (trigger                      ),
        .medida    ({ medida2, medida1, medida0 }),
        .pronto    (pronto                       ),
        .db_estado ()
    );

endmodule
