-- SHOW DATABASES;

DROP SCHEMA IF EXISTS BrumaLanches;

CREATE SCHEMA BrumaLanches;

USE BrumaLanches;

CREATE TABLE Endereco(
	idEndereco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(45) NOT NULL,
    numero VARCHAR(45) NOT NULL,
    complemento VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL	
);

DESCRIBE Endereco;

CREATE TABLE Funcionario(
	idFuncionario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    apelido VARCHAR(45) NOT NULL,
    matricula VARCHAR(11) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    rg VARCHAR(11) NOT NULL,
    Endereco_idEndereco INT NOT NULL,
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco)
);

DESCRIBE Funcionario;

CREATE TABLE Telefone(
	idTelefone INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ddd VARCHAR(2) NOT NULL,
    numero VARCHAR(9) NOT NULL
);

DESCRIBE Telefone;

CREATE TABLE Cliente(
	idCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    Endereco_idEndereco INT NOT NULL,
	Telefone_idTelefone INT NOT NULL,
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco),
    FOREIGN KEY (Telefone_idTelefone) REFERENCES Telefone(idTelefone)
);

DESCRIBE Cliente; 
 
CREATE TABLE ItemDeCardapio(
	idItemDeCardapio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    porcao VARCHAR(45) NOT NULL,
    preco_unitario FLOAT NOT NULL
);

DESCRIBE ItemDeCardapio;

CREATE TABLE Ingrediente(
	idIngrediente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL
);

DESCRIBE Ingrediente;

CREATE TABLE ItemDeCardapio_has_Ingrediente(
	ItemDeCardapio_idItemDeCardapio INT NOT NULL,
	Ingrediente_idIngrediente INT NOT NULL,
    FOREIGN KEY (ItemDeCardapio_idItemDeCardapio) REFERENCES ItemDeCardapio(idItemDeCardapio),
    FOREIGN KEY (Ingrediente_idIngrediente) REFERENCES Ingrediente(idIngrediente)
);

DESCRIBE ItemDeCardapio_has_Ingrediente;

CREATE TABLE Pedido(
	idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    data_hora_pedido DATETIME NOT NULL,
    observacoes TEXT NULL,
    valor_servico FLOAT NOT NULL,
    valor_delivery VARCHAR(45) NOT NULL,
    Cliente_idCliente INT NOT NULL,
    ItemDeCardapio_idItemDeCardapio INT NOT NULL,
    Funcionario_idFuncionario INT NOT NULL,
    Endereco_idEndereco INT NOT NULL,
	FOREIGN KEY (Cliente_idCliente ) REFERENCES Cliente(idCliente),
    FOREIGN KEY (ItemDeCardapio_idItemDeCardapio) REFERENCES ItemDeCardapio(idItemDeCardapio),
    FOREIGN KEY (Funcionario_idFuncionario) REFERENCES Funcionario(idFuncionario),
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco)
);

DESCRIBE Pedido;

CREATE TABLE Itens_de_Pedido(
	Pedido_idPedido INT NOT NULL,
    ItemDeCardapio_idItemDeCardapio INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (ItemDeCardapio_idItemDeCardapio) REFERENCES ItemDeCardapio(idItemDeCardapio)
);

DESCRIBE Itens_de_Pedido;

INSERT INTO Endereco(idEndereco, logradouro, numero, complemento, bairro, cidade)
VALUES (1, 'Rua dos Estudantes', '140', '46100000', 'Ginásio Industrial', 'Brumado'), (2, 'Avenida Otávio Mangabeira', '240', '46100000', 'Nobre', 'Brumado'), (3, 'Rua José Alves da Silva', '300', '46100000', 'Parque Alvorada', 'Brumado');

INSERT INTO Funcionario(idFuncionario, nome, sobrenome, apelido, matricula, cpf, rg, Endereco_idEndereco)
VALUES (1, 'Auli', 'Cravalho', "Auli'i", '20221522001', '9078563412', '0192837465', 1), (2, 'Idina', 'Menzel', 'Elsa', '20221522002', '5647382910', '1029384756', 2), (3, 'Christopher', 'Evans', 'Chris', '20221522003', '0123456789', '9876543210', 3);

INSERT INTO Telefone(idTelefone, ddd, numero)
VALUES (1, '77', '998002901'), (2, '11', '991622004'), (3, '75', '990752134');

INSERT INTO Cliente(idCliente, nome, sobrenome, email, cpf, Endereco_idEndereco, Telefone_idTelefone)
VALUES(1, 'Mário', 'Palmas', 'palmasmario@gmail.com', '0798635421', 1, 1), (2, 'José', 'Alberto', 'joseralbertoalves@gmail.com', '1324657980', 2, 2), (3, 'Maria', 'Júlia', 'mariajuliasantos@gmail.com', '0897564231', 3, 3);

INSERT INTO ItemDeCardapio(idItemDeCardapio, nome, porcao, preco_unitario)
VALUES (1, 'Spicy Burger','1', '4.99'), (2, 'American Burger', '1', '6.99'), (3, 'Italian Pizza', '1', '3.99');

INSERT INTO Ingrediente(idIngrediente, nome)
VALUES(1, 'Hambúger picante com carne e cebolha grelhada'), (2, 'Carne, cenoura, cebola, coberto com cebola grelhada'), (3, 'Delicosa pizza com queijo e cenoura, orégano e tomate');

INSERT INTO ItemDeCardapio_has_Ingrediente(ItemDeCardapio_idItemDeCardapio, Ingrediente_idIngrediente)
VALUES(1, 1), (2, 2), (3, 3);

INSERT INTO Pedido(IdPedido, data_hora_pedido, observacoes, valor_servico, valor_delivery, Cliente_idCliente, ItemDeCardapio_idItemDeCardapio, Funcionario_idFuncionario, Endereco_idEndereco)
VALUES(1, '2022-07-23 14:48:14', 'remover cebola', 4.99, 2.99 , 1, 1, 1, 1), (2, '2022-08-16 13:59:05', 'carne ao ponto', 4.50 , 3.50 , 2, 2, 2, 2), (3, '2022-08-16 13:59:27', '1', 5.50, 6.99, 3, 3, 3, 3);

INSERT INTO Itens_de_pedido(Pedido_idPedido, ItemDeCardapio_idItemDeCardapio, quantidade)
VALUES(1, 1, 2), (2, 2, 4), (3, 3, 6);

SELECT * FROM Endereco;

SELECT * FROM Funcionario;

SELECT * FROM Cliente;

SELECT * FROM Telefone;

SELECT * FROM ItemDeCardapio;

SELECT * FROM Ingrediente;

SELECT * FROM ItemDeCardapio_has_Ingrediente;

SELECT * FROM Pedido;

SELECT * FROM Itens_de_pedido;

SELECT
    c.nome AS 'Nome',
    c.sobrenome AS 'Sobrenome',
    c.cpf AS 'CPF',
    t.ddd AS 'DDD',
    t.numero AS 'Número',
    e.logradouro AS 'Logradouro',
    e.numero AS 'Número',
    e.bairro AS 'Bairro',
    e.cidade AS 'Cidade'
FROM Endereco e
INNER JOIN Cliente c
ON e.idEndereco = c.Endereco_idEndereco
INNER JOIN Telefone t
ON t.idTelefone = c.Telefone_idTelefone;

SELECT
	f.nome AS 'Nome',
    f.sobrenome AS 'Sobrenome',
    f.matricula AS 'Matrícula',
    f.rg AS 'RG',
    f.cpf AS 'CPF',
    e.logradouro AS 'Logradouro',
    e.numero AS 'Número',
    e.bairro AS 'Bairro',
    e.cidade AS 'Cidade'
FROM Endereco e
INNER JOIN Funcionario f
ON e.idEndereco = f.Endereco_idEndereco;

SELECT
	c.nome AS 'Nome',
    c.sobrenome AS 'Sobrenome',
    c.cpf AS 'CPF',
    f.nome AS 'Nome',
    f.sobrenome AS 'Sobrenome',
    f.matricula AS 'Matrícula',
    f.rg AS 'RG',
    f.cpf AS 'CPF',
    p.data_hora_pedido AS 'Data e Hora',
    p.observacoes AS 'Observações',
    p.valor_servico AS 'Valor do Serviço',
    p.valor_delivery AS'Valor do Delivery'
FROM Cliente c
INNER JOIN Pedido p
ON c.idCliente = p.Cliente_idCliente
INNER JOIN Funcionario f
ON f.idFuncionario = p.Funcionario_idFuncionario;