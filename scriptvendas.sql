/*Modelagem de DataWarehouse Star Schema - Tabela Fato F_VENDA e Tabelas Dimensão D_PRODUTO, D_DATA, D_LOJA */

/*Inicialmente criamos as Tabelas Dimensão devido as Primary Key */

CREATE TABLE D_Produto (
  IdProduto INT NOT NULL IDENTITY PRIMARY KEY,
  Nome_Produto VARCHAR(255),
  Categoria VARCHAR(255),
  Marca VARCHAR(50)
  );
  
  CREATE TABLE D_Data (
    IdData INT NOT NULL IDENTITY PRIMARY KEY,
    Data_Venda VARCHAR(255),
    Semestre INT,
    ANO INT
  );
  
  CREATE TABLE D_Loja (
    IdLoja INT NOT NULL IDENTITY PRIMARY KEY,
    Nome_Loja VARCHAR(255)
  );
  
  /*Criação da Tabela Fato*/
  
CREATE TABLE F_Venda(	
    idproduto INT NOT NULL,
    idloja INT NOT NULL,
    iddata INT NOT NULL,
    Valor INT,
    Quantidade INT,
    CONSTRAINT fk_idprod FOREIGN KEY (idproduto) REFERENCES D_Produto(idproduto),
    CONSTRAINT fk_idloja FOREIGN KEY(idloja) REFERENCES D_Loja(idloja),
    CONSTRAINT fk_iddata FOREIGN KEY (iddata) REFERENCES D_Data(iddata)
  );
  
  /*Inserindo dados nas tabelas */
  
  INSERT INTO D_Loja (nome_loja) VALUES
  ('Central'),
  ('Subúrbio'),
  ('Interior');
  
  INSERT INTO D_Produto (nome_produto, categoria, marca) VALUES
  ('Geladeira', 'Eletrodoméstico', 'Frozen'),
  ('Celular', 'Telefonia', 'Radar'),
  ('Pneu', 'Automotivo', 'Frota');
  
  INSERT INTO D_Data (data_venda, semestre, ano) VALUES
  ('01/02/2015',1 , 2015),
  ('10/07/2017',2 , 2017),
  ('06/11/2018',2 , 2018),
  ('25/12/2017',2 , 2017),
  ('01/02/2017',1 , 2017),
  ('06/11/2018',2 , 2015),
  ('09/03/2016',1 , 2016);
  
  INSERT INTO F_Venda (idproduto, idloja, iddata, valor, quantidade) VALUES
  (1,1,1,1000,2),
  (2,1,2,1000,1),
  (1,1,3,1000,1),
  (2,2,4,700,3),
  (2,2,4,700,1),
  (1,3,5,150,4),  
  (1,3,6,150,4),
  (2,3,5,150,2),
  (2,3,7,150,1);
    
/* Realizando uma modelagem dimensional cubo OLAP para consulta dos dados das tabelas */

SELECT * FROM F_Venda JOIN D_Produto on F_Venda.idproduto = D_Produto.idproduto JOIN D_Loja ON F_Venda.idloja = D_Loja.idloja JOIN D_Data ON F_Venda.iddata = D_Data.iddata;

