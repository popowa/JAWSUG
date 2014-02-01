#VPC Genesis
#神様、始めました。創世記 - AWS.VPC-


##Day1
AWSアカウントを作成するスクリプトです。
全部は自動化出来ないので、途中までです。

- AWSアカウント作成後に手動で行う必要がある作業
-- IAMアカウント作成
-- IAMアカウントにVPC/EC2のフルアクセスを付与する
-- 本コードDay0.rbにアクセスキーとシークレットアクセスキーを配置する

To create AWS account half-automatically.
Creating AWS account can't be full automated. 
So this code only covers half of it.


##Day2
VPCを作成するスクリプトです。

Code to create VPC (only)

##Day3
Internet Gatewayを作成しVPCに紐付けをスクリプトです。


Code to create Internet Gateway and assaign to VPC.


##Day4
Subnet、RouteTableを作成し、RouteTableにRouteを新規追加し、Internet Gatewayを紐付け、Subnetに紐付けを行う

Code to create Subnet, RouteTable, adding Route with Internet Gateway and replace Route Table to new Subnet.

##Day5
Security Group作成、Inbound, Outboundの設定を行う

Code to create security group and set inbound and outbound

##Day6
EC2インスタンスをVPC内に起動させて、EIPを取得し、紐付けを行う

Code to launch EC2 instance and allocate EIP and associate EIP to EC2

##Day7
作成したリソースを全部表示させる

Code to describe all resource that these code created.


