
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
//import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Ensure that <...>",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        let wallet_1 = accounts.get('wallet_1')!;
        let wallet_2 = accounts.get('wallet_2')!;
        let block = chain.mineBlock([
            Tx.contractCall('voting-core-v1', 'voter-registration',[], wallet_1.address),
            Tx.contractCall('voting-core-v1', 'vote',[types.int(1)], wallet_1.address),
            Tx.contractCall('voting-core-v1', 'voter-registration',[], wallet_2.address),
            Tx.contractCall('voting-core-v1', 'vote',[types.int(1)], wallet_2.address),
            Tx.contractCall('voting-core-v1', 'vote-results',[], wallet_2.address),
            /* 
             * Add transactions with: 
             * Tx.contractCall(...)
            */
        ]);
        console.log(block.receipts[0].result);
        console.log(block.receipts[1].result);
        console.log(block.receipts[2].result);
        console.log(block.receipts[3].result);
        console.log(block.receipts[4].result);
    },
});
