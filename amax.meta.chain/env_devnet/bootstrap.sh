# echo "all done..." && exit 0
# ssh -L 28888:127.0.0.1:28888 -C -N sh-amnod.amax.dev -p 19888 &


amaxOwnerPubKey=AM5SMw8Lum7MG9V61LQz8enJyM9MB7WBpvoiXsp5YmAJXZmE92j2
amaxActivePubKey=AM5SMw8Lum7MG9V61LQz8enJyM9MB7WBpvoiXsp5YmAJXZmE92j2
sys_accounts=(
    'amax.msig'
    'amax.names'
    'amax.ram'
    'amax.ramfee'
    'amax.stake'
    'amax.token'
    'amax.rex'
    'cnyd.token'
)
user_accounts=(
)
contracts=(
    'amax amax.system'
    'amax.msig amax.msig'
    'cnyd.token amax.xtoken'
)
reserved_accounts=(

)

## This is to run locally

echo "### 1. unlock wallet"
# amcli wallet unlock -n amax-core

source .env

# echo "## 1. set active key for `amax` (skip - TODO)#
# amax set account permission ${contract} active --add-code

echo "## Create system accounts..."
for acct_info in "${sys_accounts[@]}"; do
  IFS=' ' read -r -a acct_array <<< "$acct_info"
  acct=${acct_array[0]}
  acctActiveKey="${acct_array[1]}"
  # echo "pub_key --> $acctActiveKey"
  amcli create account amax $acct $amaxOwnerPubKey $acctActiveKey -p amax@active
  sleep 1
done
echo "....finishing creating system accounts..." && sleep 3

echo "## Create user accounts..."
for acct_info in "${user_accounts[@]}"; do
  IFS=' ' read -r -a array <<< "$acct_info"
  acct=${array[0]}
  acctActiveKey="${array[1]}"
  amcli create account amax $acct $acctActiveKey -p amax@active
  sleep 1
done
echo "....finishing creating user accounts..." && sleep 3

bash ./set_amax.token.sh

BOOTSTRAP_DIR=../../../bootstrap
echo "enable features..."
bash $BOOTSTRAP_DIR/bin/enable_features.sh
echo "finishing enabling features..." & sleep 3

for contract_info in "${contracts[@]}"; do
  IFS=' ' read -r -a array <<< "$contract_info"
  acct=${array[0]}
  contract="${array[1]}"
  echo "# Deploy contract: $contract"
  amcli set contract $acct $BOOTSTRAP_DIR/$contract -p $acct@active
  echo "finishing deploying $cct..." & sleep 3
done

echo "init amax.system..."
amcli push action amax init '[0, "8,AMAX"]' -p amax@active
echo "finishing init AMAX"
sleep 3

echo "Designate amax.msig as privileged account"
amcli push action amax setpriv '["amax.msig", 1]' -p amax@active
echo "finished setpriv...final step!!!"
sleep 1
echo
echo
echo "Congrats for AMAX mainnet launch!!!"

echo 
echo "check amax.token accounts...."
## check accounts
amcli get table amax.token amax accounts