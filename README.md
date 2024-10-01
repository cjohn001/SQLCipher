Want to build yourself?

Generate SQLCipher amalgamation following the official tutorial: 
https://www.zetetic.net/sqlcipher/ios-tutorial/

git clone https://github.com/sqlcipher/sqlcipher.git
cd sqlcipher
./configure --with-crypto-lib=none
make sqlite3.c

- Replace sqlite3.c and sqlite3.h in SQLCipher folder
- create xcframework by running ./build.sh