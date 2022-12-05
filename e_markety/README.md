# Important

### Run this script after creating the database and before adding data

```postgresql
CREATE TYPE tag_enum AS ENUM ('CASA', 'TRABALHO', 'OUTRO');
CREATE TYPE status_pedido_enum AS ENUM ('REALIZADO', 'CONFIRMADO', 'PRONTO_PARA_RETIRADA', 'PRONTO_PARA_ENTREGA', 'SAIU_PARA_ENTREGA', 'ENTREGUE');
CREATE TYPE tipo_entrega_enum AS ENUM ('RETIRADA', 'ENTREGA');
CREATE TYPE cargo_enum AS ENUM ('ADMIN', 'CLIENTE', 'FUNCIONARIO');
```
