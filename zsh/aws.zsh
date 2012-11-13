# EC2 CLI API
if [ -e "$HOME/bin/ec2-api-tools" ]; then
  export EC2_HOME="$HOME/bin/ec2-api-tools"
  export PATH=$PATH:$EC2_HOME/bin
  # TODO Unmacify java_home
  export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home/"
  export EC2_CERT="$HOME/.secrets/p/development/aws-zest-p-cert.pem"
  export EC2_PRIVATE_KEY="$HOME/.secrets/p/development/aws-zest-p-privatekey.pkcs8"
fi


if [ -e "$HOME/bin/ElasticLoadBalancing" ]; then
  export AWS_ELB_HOME=$HOME/bin/ElasticLoadBalancing
  export PATH=$PATH:$HOME/bin/ElasticLoadBalancing/bin
fi
