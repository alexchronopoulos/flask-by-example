ecr=$(aws ecr describe-repositories --query "repositories[*].repositoryUri" --output text)
if [ $1 == 'push' ]
then
    aws ecr get-login-password | docker login --username AWS --password-stdin $ecr
    docker tag flask-by-example $ecr
    docker push $ecr
fi

if [ $1 == 'delete' ]
then
    aws ecr delete-repository --repository-name $(aws ecr describe-repositories --query "repositories[*].repositoryName" --output text) --force
fi