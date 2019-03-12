# chama-passport

POC



- - -

## Dev


### Build & deploy

1. `aragon devchain`
1. `aragon ipfs`
1. `aragon run --debug --kit Kit --kit-init @ARAGON_ENS`
	- Also there is a little faster way but is's has bugs/problems and ipfs is needed yet: `npm run start:aragon:http -- --kit Kit --kit-init @ARAGON_ENS`.

_Or one cmd for all: `aragon run --debug --kit Kit --kit-init @ARAGON_ENS`._

Then get app-address from output and attach the app into another DAO with `dao install {0xDAOaddr} passport` (here `passport` is app-address).
