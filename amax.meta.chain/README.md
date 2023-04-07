# Create a portable snapshot

1. Enable the `producer_api_plugin` on a node with full state-history.
2. Create a portable snapshot:
```
curl http://127.0.0.1:8888/v1/producer/create_snapshot | json_pp
```

3. Wait for `amnod` to process several blocks after the snapshot completed. The goal is for the `state-history` files to contain at least 1 more block than the portable snapshot has, and for the blocks.log file to contain the block after it has become irreversible.

4. Stop amnod.
Make backups of:

The newly-created portable snapshot (data/snapshots/snapshot-xxxxxxx.bin)
The contents of data/state-history:

- chain_state_history.log
- trace_history.log
- chain_state_history.index: optional. Restoring will take longer without this file.
- trace_history.index: optional. Restoring will take longer without this file.

Optional: the contents of data/blocks, but excluding data/blocks/reversible.
