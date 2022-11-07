package br.edu.utfpr.e_markety.model.enums;

// CREATE TYPE status_pedido_enum AS ENUM ('PENDENTE', 'REALIZADO', 'CONFIRMADO', 'PRONTO_PARA_RETIRADA', 'PRONTO_PARA_ENTREGA', 'SAIU_PARA_ENTREGA', 'ENTREGUE');
public enum StatusPedido {
    PENDENTE {
        @Override
        public StatusPedido getNext(TipoEntrega tipoEntrega) {
            return REALIZADO;
        }
    },
    REALIZADO {
        @Override
        public StatusPedido getNext(TipoEntrega tipoEntrega) {
            return CONFIRMADO;
        }
    },
    CONFIRMADO {
        @Override
        public StatusPedido getNext(TipoEntrega tipoEntrega) {
            return tipoEntrega == TipoEntrega.RETIRADA ? PRONTO_PARA_RETIRADA : PRONTO_PARA_ENTREGA;
        }
    },
    PRONTO_PARA_RETIRADA {
        @Override
        public StatusPedido getNext(TipoEntrega tipoEntrega) {
            return ENTREGUE;
        }
    },
    PRONTO_PARA_ENTREGA {
        @Override
        public StatusPedido getNext(TipoEntrega tipoEntrega) {
            return SAIU_PARA_ENTREGA;
        }
    },
    SAIU_PARA_ENTREGA {
        @Override
        public StatusPedido getNext(TipoEntrega tipoEntrega) {
            return ENTREGUE;
        }
    },
    ENTREGUE {
        @Override
        public StatusPedido getNext(TipoEntrega tipoEntrega) {
            return ENTREGUE;
        }
    };

    public abstract StatusPedido getNext(TipoEntrega tipoEntrega);
}
