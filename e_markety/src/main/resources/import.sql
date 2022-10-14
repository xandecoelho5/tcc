INSERT INTO BAIRRO(NOME) VALUES ('Aeroporto');
INSERT INTO BAIRRO(NOME) VALUES ('Centro');
INSERT INTO BAIRRO(NOME) VALUES ('Barro Preto');
INSERT INTO BAIRRO(NOME) VALUES ('Andorinhas');
INSERT INTO BAIRRO(NOME) VALUES ('Planalto');
INSERT INTO BAIRRO(NOME) VALUES ('Américo Caetano');
INSERT INTO BAIRRO(NOME) VALUES ('Dona Benta');
INSERT INTO BAIRRO(NOME) VALUES ('Aleixo Araújo');
INSERT INTO BAIRRO(NOME) VALUES ('Mithakhali');
INSERT INTO BAIRRO(NOME) VALUES ('Pondichory');

INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Fruits & Vegetables', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0XFF4CA64C');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Dairy & Bakery', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0xFFD39447');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Staples', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0xFF7E724C');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Snacks & Branded Foods', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0xFFB34F2D');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Beverages', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0xFF646A8A');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Personal Care', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0XFF945DA1');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Home Care', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0XFF2788BB');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Baby Care', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0XFFF2598D');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Home & Kitchen', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0XFF787161');
INSERT INTO CATEGORIA(NOME, IMAGEM_URL, ICON_URL, COR) VALUES('Pet Foods', 'assets/images/fruits_and_vegetables.png', 'assets/icons/fruits_and_vegetables_icon.png', '0XFFB7823C');

INSERT INTO UNIDADE_MEDIDA(DESCRICAO) VALUES('UN');
INSERT INTO UNIDADE_MEDIDA(DESCRICAO) VALUES('KG');
INSERT INTO UNIDADE_MEDIDA(DESCRICAO) VALUES('LT');

INSERT INTO USUARIO(NOME, EMAIL, SENHA, IMAGEM_URL, ADMIN) VALUES('Testezera', 'teste@t.com', '$2a$10$whun6s9AXYDjiWqJVWnjiOa56fP2Suu2VesHBMyPfsF7q56hLo9oG', 'https://avatars.githubusercontent.com/u/45719696', true);
INSERT INTO USUARIO(NOME, EMAIL, SENHA, IMAGEM_URL, ADMIN) VALUES('Lucy Martin', 'lucymartin@gmail.com', '$2a$10$whun6s9AXYDjiWqJVWnjiOa56fP2Suu2VesHBMyPfsF7q56hLo9oG', 'https://avatars.githubusercontent.com/u/45719696', false);
INSERT INTO USUARIO(NOME, EMAIL, SENHA, IMAGEM_URL, ADMIN) VALUES('Administro', 'admin@gmail.com', '$2a$10$whun6s9AXYDjiWqJVWnjiOa56fP2Suu2VesHBMyPfsF7q56hLo9oG', 'https://avatars.githubusercontent.com/u/45719696', true);

INSERT INTO ENDERECO(TAG, NOME, TELEFONE, RUA, REFERENCIA, PADRAO, BAIRRO_ID, USUARIO_ID) VALUES('CASA', 'Lucy Martin', '+91 234 567 8900', 'A/234, Kigs Plaza', 'Near the city', true, 9, 2);
INSERT INTO ENDERECO(TAG, NOME, TELEFONE, RUA, REFERENCIA, PADRAO, BAIRRO_ID, USUARIO_ID) VALUES('TRABALHO', 'John Martin', '+91 567 890 2340', 'B/104, Lawesh Tower', '', false, 10, 2);
INSERT INTO ENDERECO(TAG, NOME, TELEFONE, RUA, REFERENCIA, PADRAO, BAIRRO_ID, USUARIO_ID) VALUES('OUTRO', 'Mercado Teste', '343811-1736', 'Rua dos Pistoleiros, 97', 'Perto do centro', true, 3, 1);
INSERT INTO ENDERECO(TAG, NOME, TELEFONE, RUA, REFERENCIA, PADRAO, BAIRRO_ID, USUARIO_ID) VALUES('OUTRO', 'Mercado Teste 2', '343811-1111', 'Rua das Araras, 122', '', true, 1, 3);

INSERT INTO EMPRESA(NOME, TELEFONE, CELULAR, LOGO, DELIVERY_ABERTURA, DELIVERY_FECHAMENTO, LOJA_ABERTURA, LOJA_FECHAMENTO, ENDERECO_ID) VALUES('Mercado Teste', '343811-1736', '349891-1736', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpt.m.wikipedia.org%2Fwiki%2FFicheiro%3ALogo_TV_2015.png&psig=AOvVaw1rSjeFvMZXN0XnvPhSZYqr&ust=1665820177733000&source=images&cd=vfe&ved=0CA0QjRxqFwoTCPChyd2d3_oCFQAAAAAdAAAAABAE', '09:00', '17:00', '08:00', '19:00', 3);
INSERT INTO EMPRESA(NOME, TELEFONE, CELULAR, LOGO, DELIVERY_ABERTURA, DELIVERY_FECHAMENTO, LOJA_ABERTURA, LOJA_FECHAMENTO, ENDERECO_ID) VALUES('Mercado Teste 2', '343811-1111', '349999-1736', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpt.m.wikipedia.org%2Fwiki%2FFicheiro%3ALogo_TV_2015.png&psig=AOvVaw1rSjeFvMZXN0XnvPhSZYqr&ust=1665820177733000&source=images&cd=vfe&ved=0CA0QjRxqFwoTCPChyd2d3_oCFQAAAAAdAAAAABAE', '09:00', '17:00', '08:00', '19:00', 3);

INSERT INTO EMPRESA_BAIRRO(EMPRESA_ID, BAIRRO_ID, TAXA_ENTREGA) VALUES(1, 1, 5.00);
INSERT INTO EMPRESA_BAIRRO(EMPRESA_ID, BAIRRO_ID, TAXA_ENTREGA) VALUES(1, 2, 4.00);
INSERT INTO EMPRESA_BAIRRO(EMPRESA_ID, BAIRRO_ID, TAXA_ENTREGA) VALUES(1, 3, 3.00);
INSERT INTO EMPRESA_BAIRRO(EMPRESA_ID, BAIRRO_ID, TAXA_ENTREGA) VALUES(1, 9, 7.00);
INSERT INTO EMPRESA_BAIRRO(EMPRESA_ID, BAIRRO_ID, TAXA_ENTREGA) VALUES(1, 10, 12.00);
INSERT INTO EMPRESA_BAIRRO(EMPRESA_ID, BAIRRO_ID, TAXA_ENTREGA) VALUES(2, 1, 8.00);
INSERT INTO EMPRESA_BAIRRO(EMPRESA_ID, BAIRRO_ID, TAXA_ENTREGA) VALUES(2, 2, 7.00);
INSERT INTO EMPRESA_BAIRRO(EMPRESA_ID, BAIRRO_ID, TAXA_ENTREGA) VALUES(2, 3, 6.00);

INSERT INTO PRODUTO(NOME, IMAGEM_URL, DESCRICAO, PRECO, DATA, ESTOQUE, FAVORITO, PESO_PRECO, PESO_UNIDADE, PERCENTUAL_DESCONTO, UNIDADE_MEDIDA_ID, CATEGORIA_ID, EMPRESA_ID) VALUES('Broccoli', 'https://toppng.com/uploads/preview/broccoli-11546982769b24nyuwjow.png', 'A green broccoli made with love from modern farmers', 85.00, '2020-05-01', 100, true, 1, 0.05, 0, 2, 1, 1);
INSERT INTO PRODUTO(NOME, IMAGEM_URL, DESCRICAO, PRECO, DATA, ESTOQUE, FAVORITO, PESO_PRECO, PESO_UNIDADE, PERCENTUAL_DESCONTO, UNIDADE_MEDIDA_ID, CATEGORIA_ID, EMPRESA_ID) VALUES('Delight Nuts Raw Seeds Pumpkin', 'https://www.pngitem.com/pimgs/m/121-1218157_delight-nuts-dry-fruits-all-png-download-delight.png', 'A Delight Nuts Raw Seeds Pumpkin', 165.00, '2021-05-01', 20, false, 0.75, 0.75, 0, 2, 3, 1);
INSERT INTO PRODUTO(NOME, IMAGEM_URL, DESCRICAO, PRECO, DATA, ESTOQUE, FAVORITO, PESO_PRECO, PESO_UNIDADE, PERCENTUAL_DESCONTO, UNIDADE_MEDIDA_ID, CATEGORIA_ID, EMPRESA_ID) VALUES('Bakery Panini Small Bread Basket', 'https://e7.pngegg.com/pngimages/170/798/png-clipart-bakery-panini-small-bread-basket-bread-material-free-to-pull-baked-goods-free-logo-design-template-thumbnail.png', 'Bakery Panini Small Bread Basket', 38.32, '2022-05-01', 100, false, 1, 0.5, 15, 2, 2, 1);
INSERT INTO PRODUTO(NOME, IMAGEM_URL, DESCRICAO, PRECO, DATA, ESTOQUE, FAVORITO, PESO_PRECO, PESO_UNIDADE, PERCENTUAL_DESCONTO, UNIDADE_MEDIDA_ID, CATEGORIA_ID, EMPRESA_ID) VALUES('Britannia Bourbon Original Cream Biscuits', 'https://unidexmobile.com/img/products/E022005.png', 'A Britannia Bourbon Original Cream Biscuits', 85.00, '2022-10-10', 40, false, 0.75, 0.75, 0, 2, 4, 1);

INSERT INTO PEDIDO(DATA, TOTAL, TIPO_ENTREGA, HORARIO_ENTREGA, STATUS, OBSERVACAO, TAXA_ENTREGA, USUARIO_ID, ENDERECO_ID) VALUES ('2021-05-01', 625.00, 'RETIRADA', NULL, 'REALIZADO', 'No Observation!!', NULL, 2, NULL);
INSERT INTO PEDIDO(DATA, TOTAL, TIPO_ENTREGA, HORARIO_ENTREGA, STATUS, OBSERVACAO, TAXA_ENTREGA, USUARIO_ID, ENDERECO_ID) VALUES ('2022-05-01', 85.00, 'RETIRADA', NULL, 'CONFIRMADO', 'I will arrive in two hours', NULL, 2, NULL);
INSERT INTO PEDIDO(DATA, TOTAL, TIPO_ENTREGA, HORARIO_ENTREGA, STATUS, OBSERVACAO, TAXA_ENTREGA, USUARIO_ID, ENDERECO_ID) VALUES ('2022-10-10', 36.00, 'RETIRADA', NULL, 'PRONTO_PARA_RETIRADA', 'Hahahaha troller', NULL, 2, NULL);
INSERT INTO PEDIDO(DATA, TOTAL, TIPO_ENTREGA, HORARIO_ENTREGA, STATUS, OBSERVACAO, TAXA_ENTREGA, USUARIO_ID, ENDERECO_ID) VALUES ('2022-09-09', 22.00, 'ENTREGA', '2022-09-09 16:00:00', 'PRONTO_PARA_ENTREGA', 'Please deliver the order as soon as possible', 7, 2, 1);
INSERT INTO PEDIDO(DATA, TOTAL, TIPO_ENTREGA, HORARIO_ENTREGA, STATUS, OBSERVACAO, TAXA_ENTREGA, USUARIO_ID, ENDERECO_ID) VALUES ('2022-08-08', 95.00, 'ENTREGA', '2022-08-08 14:00:00', 'SAIU_PARA_ENTREGA', 'Vem rápido que tô faminto...', 12, 2, 2);
INSERT INTO PEDIDO(DATA, TOTAL, TIPO_ENTREGA, HORARIO_ENTREGA, STATUS, OBSERVACAO, TAXA_ENTREGA, USUARIO_ID, ENDERECO_ID) VALUES ('2022-07-07', 125.00, 'ENTREGA', '2022-07-07 12:00:00', 'ENTREGUE', 'Aaaaaaaaaaaaaaiioooooooooooooooouuu', 7, 2, 1);

INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (1, 1, 1);
INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (2, 1, 2);
INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (1, 1, 3);
INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (5, 1, 4);
INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (1, 2, 1);
INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (2, 3, 2);
INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (3, 4, 4);
INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (4, 5, 3);
INSERT INTO PEDIDO_ITEM(QUANTIDADE, PEDIDO_ID, PRODUTO_ID) VALUES (5, 6, 1);
