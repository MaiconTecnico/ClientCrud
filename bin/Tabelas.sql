CREATE TABLE CLIENTE (
	ID INTEGER PRIMARY KEY AUTOINCREMENT,
	NOME VARCHAR(40),
	IDENTIDADE VARCHAR(40),
	CPF VARCHAR(15),
	TELEFONE VARCHAR(20),
	EMAIL VARCHAR(100)
	);  
	
CREATE TABLE CLIENTE_ENDERECO(  
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  ID_CLIENTE INTEGER,
  CEP VARCHAR(20),
  LOGRADOURO VARCHAR(120),
  NUMERO INTEGER,
  COMPLEMENTO VARCHAR(200),
  BAIRRO VARCHAR(80),
  CIDADE VARCHAR(80),
  ESTADO VARCHAR(2),
  PAIS VARCHAR(80),
  IND_PRINCIPAL VARCHAR(1),
  FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID)
);