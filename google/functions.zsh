gssh () {
    ssh -i ~/.ssh/google_compute_engine -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no -A $@
}