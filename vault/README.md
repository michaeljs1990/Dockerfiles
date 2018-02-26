# Vault

## Init

To start you will need to initialize your vault. This can be done by
running the following command inside the docker container.

```
vault operator init
```

Make sure to save the Keys and Root Token for later. You will need these
keys if you ever want to restart or seal your server.

## Unseal

Since the default init creates five keys and has a threshold of three you
will need to enter three keys un unlock your vault the first time.

```
vault operator unseal
vault operator unseal
vault operator unseal
```

To verify if your vault has been unsealed you can run the following and 
verify the output looks something like the following.

```
/ # vault operator unseal
Unseal Key (will be hidden): 
Key             Value
---             -----
Seal Type       shamir
Sealed          false
Total Shares    5
Threshold       3
Version         0.9.4
Cluster Name    vault-cluster-09d063a6
Cluster ID      ac1a5c23-4292-ac72-4e2c-e3f887b4d762
HA Enabled      false
```

## Login

To login as the root user use the Root Token from above and issue

```
vault login
```

You will now be able to properly configure your vault server.

## Policy

Now that you are logged in with a root user you can begin to make some policies
that you think makes sense for your org. You write the policies in a flat file
and then issue a command to write them to the vault db. For example files look
in the policy folder that I have here.

To create the policies and then list them you can issue the following commands

```
/vault/policy # vault policy write shared shared.hcl 
Success! Uploaded policy: shared

/vault/policy # vault policy write nodeclass-devnode nodeclass/devnode.hcl 
Success! Uploaded policy: nodeclass-devnode

/vault/policy # vault policy list
shared
nodeclass-devnode
default
root
```

Read https://www.vaultproject.io/docs/concepts/policies.html for more info. You
can do a lot with policies that I am not covering here.

## App Roles

https://www.vaultproject.io/docs/auth/approle.html for all docs on approle.

Enable approle with the following...

```
vault auth enable approle
```

Next we need to create an approle for use.

```
vault write auth/approle/role/devnode policies="shared,nodeclass-devnode"
```

Get the id needed to login to your role we have just created as well as 
getting the secret-id which we use for making a token in the next step.

```
/vault/policy # vault read auth/approle/role/devnode/role-id
Key        Value
---        -----
role_id    c1523c3b-92c3-4695-7a85-f679a1d11847
/vault/policy # vault write -f auth/approle/role/devnode/secret-id
Key                   Value
---                   -----
secret_id             3c1801cd-f7bb-3060-91fb-3977e493d16d
secret_id_accessor    b3a2acf7-45cd-99e3-b9f1-13f80ac9368b
```

Then you can create the token...

```
/vault/policy # vault write auth/approle/login role_id=c1523c3b-92c3-4695-7a85-f679a1d11847 secret_id=3c1801cd-f7bb-3060-91fb-3977e493d16d
Key                     Value
---                     -----
token                   d8b5320c-d230-1607-8746-1eda271eeed3
token_accessor          14e178be-779a-3b19-7579-218e571b2b39
token_duration          168h
token_renewable         true
token_policies          [default nodeclass-devnode shared]
token_meta_role_name    devnode
```

Now you can use this with the normal `vault login`.

## New Users

Now that we have some policies that we can add users to lets begin by creating some
new users. Take node that when you create a user the token used to create it will be
that users parent. If the parent is disabled all children tokens will be as well. You
can use this to your advantage when setting up your servers. For instance if you have
a bunch of mysql servers you could create a mysql token and then one token for each
mysql server. If you switch from mysql to cassandra you can now just kill the mysql token
and not worry about disabling X number of tokens.


