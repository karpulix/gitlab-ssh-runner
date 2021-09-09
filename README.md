
# How use it

## Register a Runner
On your runner server
```sh
sudo gitlab-runner register   \
--url "https://git.example.ru/"   \
--registration-token "ExAmLealLWgeu"   \
--description "karpulix/gitlabci_ssh_run"   \
--executor "docker"   \
--docker-image karpulix/gitlabci_ssh_run
```


## Restart gitlab-runner
```sh
sudo gitlab-runner restart
```
Disable checkbox **Lock tp current project** in `/admin/runners` (for sharing this runner)

## Create private and public keys
```sh
mkdir -p ~/cicd-keys
ssh-keygen ~/cicd-keys/projectname
```


## Print private key
```sh
cat ~/cicd-keys/projectname
```

## Copy & save private key as Variable for your project
You Gitlab Project → Settings → CI/CD → Variables (**Use Type file**)
let it be **$SSH_RUN_PRIVATE_KEY**

## Print public key
```sh
cat ~/cicd-keys/projectname.pub
```



## Copy & add public key to target remote server in authorized_keys file
```sh
# use ssh-keygen for quick creation .ssh folder (it makes keys also)
# ssh-keygen
# enter, enter, enter ...

echo "ssh-rsa AAAAB3NzaC....SIDsBxSSR" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

## Make your pipline
```yaml
job:deploy:
  tags:
    - gitlab_ssh_run
  image: karpulix/gitlab_ssh_run
  script:
    # Initit current connection
    - ssh_init -h ssh.targethost.com -u you_username -k $SSH_RUN_PRIVATE_KEY
    # Run simple command
    - ssh_run whoami
    # Run command with params
    - ssh_run git --version
    # Run several commands with &&
    - ssh_run cd /var/www/src && ls -la
    # Run several command with YAML multiline block scalar indicator 
    - >
      ssh_run
      '
      cd ~/.ssh &&
      ls -la &&
      touch ~/ILLBEBACK
      '
```
## 

## About tilda ~
if use `~`, you shoild use quotation marks for your command else `~` will be interpreatated in host machine's context
```yaml
script:
  - ssh_init -h ssh.targethost.com -u you_username -k $SSH_RUN_PRIVATE_KEY
  - ssh_run 'touch ~/.ssh/ILLBEBACK'
```

# Parameters ssh_init


`ssh_init` `[-h host] [-k key_path] [-u user] [-p port]`

**Description**:

`-u` **user**  | *Optional, default*: `root` \
&nbsp;&nbsp;&nbsp;&nbsp; Set username for a ssh connection.  \
`-p` **port** | *Optional, default*: `22`\
&nbsp;&nbsp;&nbsp;&nbsp; Set port for a ssh connection.  \
`-h` **host** | *Required* \
&nbsp;&nbsp;&nbsp;&nbsp; Set hostname or IP for a ssh connection. \
`-k` **path** | *Required* \
&nbsp;&nbsp;&nbsp;&nbsp; Set path to private key for a ssh connection.

# Parameters ssh_run
`ssh_run` `[command]`

**Description**:
Usage any command string. See examples on this page.