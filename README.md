# Provision-GKE-Cluster
<https://learn.hashicorp.com/tutorials/terraform/gke>
C5AH - ECJQ - D7MG - UE1S - 16T2 - 5QYD]
```bash
brew cask install google-cloud-sdk

for bash users
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

  for zsh users
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

gcloud init

gcloud auth application-default login
cat ~/.config/gcloud/application_default_credentials.json

❯ gcloud projects list
PROJECT_ID        NAME       PROJECT_NUMBER
devsecops-294715  DevSecOps  141529759768

docker pull eerkunt/terraform-compliance

docker run --rm -v $PWD:/target -i -t eerkunt/terraform-compliance \
                                            -f example/example_01 \
                                            -t example/tf_files

docker run --rm -i -t eerkunt/terraform-compliance \
                            -f git:https://some.git.repository/compliance-code.git \
                            -t git:https://some.git.repository/terraform-repo.git
```

