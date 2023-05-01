yc compute instance create --name reddit-app \
  --hostname reddit-app \
  --memory=4 --cores=2 --core-fraction=5\
  --create-boot-disk image-id=fd85408f9d3gens7p6vk,size=10GB \
  --network-interface subnet-name=infra,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub