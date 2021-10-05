
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Ensure that <...>",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        let wallet_1 = accounts.get('wallet_1')!;        
        let block = chain.mineBlock([
            Tx.contractCall('main', 'say-hello',[], wallet_1.address),
            Tx.contractCall('main', 'say',[types.utf8("You rock!")], wallet_1.address),
        ]);
        console.log(block.receipts[0].result);
        console.log(block.receipts[1].result);
        assertEquals(block.receipts.length, 2);
        assertEquals(block.receipts[0].result, '(ok u"double trouble")');
    },
});
