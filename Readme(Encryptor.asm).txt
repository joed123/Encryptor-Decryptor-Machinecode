This program (Encryptor.asm) accepts three parameters which it then passes onto the stack, the requirments chnage depending on the mode its in. 
If its in decoy mode it accepts, a 16 bit signed WORD operand, a 16 bit signed WORD operand and a 32 bit signed DWORD (the sum will be placed into the specified DWORD).
Decoy mode calclates the sum of the two 16 bit operands and stores it into memory.

In encryption mode this program accepts 3 parameters on the stack and encrypts one of the parameters using the other parameter thats a key. It accepts
a 32 bit of a BYTE array (this array contains a 26 character key),
a 32 bit of a BYTE array (this array contains the plaintext message to be encrypted),
a 32 bit OFFSET of a signed DWORD (the dereferenced value initially contains the integer -1)
The encryption mode will encrypt the requested message. When the function returns, the original plaintext message array will be overwritten with the correctly encrypted message.

Decryption mode accepts 3 parameters on the stack, a 32 bit of a BYTE array (this array contains a 26 character key),
32 bit of a BYTE array (this array contains the encrypted message that is to be decoded),
32 bit of a signed DWORD (the dereferenced value initially contains the integer -2),
This part of the program will decrypt the message using the key and the passed in message.
