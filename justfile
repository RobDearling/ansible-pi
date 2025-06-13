default:
    @just --list

install-role:
    ansible-galaxy install -r requirements.yml

ping:
    ansible all -m ping

install-docker:
    ansible-playbook docker.yml

check-docker:
    ansible pis -m shell -a "docker --version && docker compose version"

clean:
    ansible-galaxy role remove geerlingguy.docker

setup: install-role ping
    @echo "✅ Setup complete!"

deploy: install-role ping install-docker check-docker
    @echo "🎉 Docker deployment completed successfully!"

info:
    ansible pis -m setup -a "filter=ansible_distribution*,ansible_kernel,ansible_architecture"

reboot:
    ansible pis -m reboot --become
