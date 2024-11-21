clear all, clc
%Input 
%The message
msg = input('Enter a message with 4 or 5 bytes ','s');
%Number of bytes
k = length(msg);
%Generate a random matrix of only 0 or 1 with dimentions (k) x (n-k) that
%follow the three Hamming code rules for 4 bytes
if k == 4
% Matrix A = codification matrix
A = [1 1 1; 0 1 1;1 0 1;1 1 0];
%For 5 bytes
elseif k==5
% Matriz A = codification matrix
A = [1 1 1 1;0 1 1 1; 1 0 1 1; 1 1 0 1; 1 1 1 0];
end
disp ("A= ")
disp(A);
%Generator matrix
G = [ eye(k) A ];

% Message Codification
%Find parity bytes of the message
codificado = mod(G' * msg',2);
disp("Message with parity bytes");
disp(codificado');
%Number of bytes of parity message
n = length(codificado);
% Verification matrix
H = [ A' eye(n-k) ];

% Add error (row, column = 1)
%User introduces error position
e = input("Enter an error in the following coordinate: ");
%For random error, comment last line and uncomment the next
%e=randi(k)
%Assign byte with complementary value on desired position
if codificado(e, 1) == 0
codificado(e, 1) = 1;
else
codificado(e, 1) = 0;
end
%Shows the message with error
disp("Message with error: ")
disp(codificado');
% If you get only 0 on decodifier, there is no error
%HWc'
disp("HWc verification': ")
verificacion = mod(H * codificado, 2);
disp(verificacion');
%For cycle to check if H is equal to HWc'
for i = 1:k
%If the verificated matrix is equal to the verification code, there is a
%mistake - fix it
if verificacion == H(:, i)
if codificado(i, 1) == 0
codificado(i, 1) = 1;
else
codificado(i, 1) = 0;
end
end
end
disp("Message without error and parity bytes: ")
disp(codificado');