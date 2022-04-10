
echo "# Deploy amax.token contract"
amcli set contract amax.token ../amax.token/ -p amax.token@active
echo "....finishing deploying..." && sleep 3

echo "## Create and allocate the SYS currency = AMAX"
amcli push action amax.token create '[ "amax", "1000000000.00000000 AMAX" ]' -p amax.token@active
echo "....finishing creating 1 bn AMAX" && sleep 3

## issue 0.9 bn
amcli push action amax.token issue  '[ "amax", "900000000.00000000 AMAX", "" ]' -p amax@active
sleep 1
echo "....finishing issue 0.9 bn AMAX"
