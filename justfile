default:
    @just --list

install:
    ansible-galaxy install -r requirements.yml
    ansible-galaxy collection install -r requirements.yml

ping:
    ansible all -m ping

install-docker:
    ansible-playbook docker.yml

deploy-app:
    ansible-playbook deploy-compose.yml

full-deploy: install
    ansible-playbook site.yml

clean:
    ansible-galaxy role remove geerlingguy.docker

setup: install ping
    @echo "✅ Setup complete!"

deploy: install ping install-docker check-docker deploy-app
    @echo "🎉 Docker and homelab applications deployment completed successfully!"

info:
    ansible pis -m setup -a "filter=ansible_distribution*,ansible_kernel,ansible_architecture"

reboot:
    ansible pis -m reboot --become
