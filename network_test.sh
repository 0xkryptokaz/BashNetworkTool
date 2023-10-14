#!/bin/bash

ping_host() {
    host=$1
    if ping -c 1 "$host" >/dev/null; then
        echo "Yes"
    else
        echo "No"
    fi
}

nslookup_host() {
    host=$1
    if result=$(nslookup "$host" 2>/dev/null); then
        echo "$result"
    else
        echo "NSLookup failed"
    fi
}

get_default_gateway() {
    gateway=$(ip route | awk '/default/ { print $3 }')
    echo "$gateway"
}

save_results() {
    filename=$1
    results=$2
    echo "$results" > "$filename"
}

main() {
    default_gateway=$(get_default_gateway)
    gateway_ping_result=$(ping_host "$default_gateway")
    dns_ping_result=$(ping_host "103.206.238.100")
    google_ping_result=$(ping_host "google.com")

    google_nslookup_result=$(nslookup_host "www.google.com")
    skymesh_nslookup_result=$(nslookup_host "www.skymesh.net.au")

    echo "Step 1: Ping Default Gateway"
    echo "Default Gateway IP: ${default_gateway:-Not found}"
    echo "Can you ping Default Gateway?: $gateway_ping_result"

    echo -e "\nStep 2: Ping DNS Server"
    echo "Can you ping DNS server (103.206.238.100)?: $dns_ping_result"

    echo -e "\nStep 3: Ping Google.com"
    echo "Can you ping google.com?: $google_ping_result"

    echo -e "\nStep 4: NSLookup"
    echo "Can you nslookup www.google.com?:"
    echo "$google_nslookup_result"
    echo -e "\nCan you nslookup www.skymesh.net.au?:"
    echo "$skymesh_nslookup_result"

    save_results "network_test_results.txt" "
Step 1: Ping Default Gateway
Default Gateway IP: ${default_gateway:-Not found}
Can you ping Default Gateway?: $gateway_ping_result

Step 2: Ping DNS Server
Can you ping DNS server (103.206.238.100)?: $dns_ping_result

Step 3: Ping Google.com
Can you ping google.com?: $google_ping_result

Step 4: NSLookup
Can you nslookup www.google.com?:
$google_nslookup_result

Can you nslookup www.skymesh.net.au?:
$skymesh_nslookup_result
"
}

main
