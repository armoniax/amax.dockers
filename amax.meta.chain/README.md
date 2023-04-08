# Create a portable snapshot

1. Enable the `producer_api_plugin` on a node with full state-history.
2. Create a portable snapshot:
```
curl http://127.0.0.1:8888/v1/producer/create_snapshot | json_pp
```

3. Wait for `amnod` to process several blocks after the snapshot completed. The goal is for the `state-history` files to contain at least 1 more block than the portable snapshot has, and for the blocks.log file to contain the block after it has become irreversible.

4. Stop amnod

Make backups of:
- The newly-created portable snapshot (`data/snapshots/snapshot-xxxxxxx.bin`)
- The contents of `data/state-history`:
  - `chain_state_history.log`
  - `trace_history.log`
  - `chain_state_history.index`: optional. Restoring will take longer without this file.
  - `trace_history.index`: optional. Restoring will take longer without this file.

Optional: the contents of data/blocks, but excluding data/blocks/reversible.

# Restore Snapshot with full state history

1. Get the following:

- A portable snapshot (`data/snapshots/snapshot-xxxxxxx.bin`)
- The contents of `data/state-history`
- Optional: a block log which includes the block the snapshot was taken at. Do *NOT* include `data/blocks/reversible`.

2. Make sure `data/state` does not exist
3. Start `amnod` with the `--snapshot` option, and the options listed in the `state_history_plugin`.
4. Do not stop `amnod` until it has received at least 1 block from the network, or it won't be able to restart.
