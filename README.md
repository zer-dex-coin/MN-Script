#Script to setup Masternode


Need a fresh VPS ubuntu with atleast 1 Gb RAM and 15 Gbs free space.
1. prepare Windows wallet: 
- go to debug console and type:
```
getnewaddress MN1
```
- send 10.000 ZDX to this address and let at least confirm by 1 blocks
- get the MN key and save in txt:
```
masternode genkey
```
2. start script in VPS console:
```
sudo apt-get install curl -y && bash <(curl -s https://raw.githubusercontent.com/zer-dex-coin/MN-Script/master/zdxmn.sh) | tee ~/zdx_masternode_installation.log
```
3. wait to ask genkey and put by control+V the info getted in 4.3 point and give enter to go on.
4. let finish and note the IP:PORT given at the end of the script execution
5. back to your windows wallet and get masternode outputs:
```
masternode outputs
```
will give you something like this: you will only need anote what are between "" 
```
txhash: "7a1ebb4baadf9ff39bbbfc2d58fd57ff15b65a5096069c8b232d3d312fb4xxxx",
outputidx: 1
```
6. open the masternode conf file and put:
```
MN1 IP:PORT masternodekey masternodeouputs txnumber
EXAMPLE: 38.25.122.251:19849 7NEGGttKZojkAzViEYXXXxKTFdAtC2uSiMg8NSFqYVBtN6mYdU 7a1ebb4baadf9ff39bbbfc2d58fd57ff15b65a5096069c8XXX3fb4cb5c 1
```
7. save masternode conf file, reopen wallet and in masternode section type select created masternode and click START (MN transaction needs at least 15 blocks to be confirmed and start to work)


Done!
