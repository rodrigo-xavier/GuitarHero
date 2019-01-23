% Cria conexão com o Arduino (verificar qual a entrada correta)
conexao = serial('COM3');
fopen(conexao);

% Envia um caracter para o arduino
% Antes disso, um código já deve estar no arduino (enviado através da própria IDE do Arduino)
% provendo a lógica do que será executado ao enviar este caracter
fprintf(conexao,'%c',char(100));

% Fecha a conexão
fclose(conexao);