#!/bin/bash
# ---------------------------------------------------------------
# + Script      : instal.sh
# + Deskripsi   : instal.sh adalah script bash untuk menginstal 
#               : alat Fcrackzip secara otomatis.
# + Pembuat     : Rofidoang03
# ---------------------------------------------------------------
# + Github      : https://github.com/rofidoang03/sbs
# ---------------------------------------------------------------

# variabel warna 
b="\e[1;34m" # biru terang
m="\e[1;31m" # merah terang 
h="\e[1;32m" # hijau terang 
p="\e[1;37m" # putih terang 
c="\e[1;36m" # cyan terang
r="\e[;0m"   # reset


function cek_koneksi_internet(){
    echo -e "${b}[*] ${p}Mengecek koneksi internet Anda...${r}"
    sleep 3
    if ping -q -c 1 -W 1 google.com >/dev/null; then
        echo -e "${h}[+] ${p}Anda memiliki koneksi internet.${r}"
        instal_depedensi
    else
        echo -e "${m}[-] ${p}Anda tidak memiliki koneksi internet.${r}"
        sleep 1
        echo -r "${p}[${c}info${p}] Pastikan Anda memiliki koneksi internet untuk menginstal alat Fcrackzip.${r}"
        exit 1
    fi
}

function instal_depedensi(){
    daftar_depedensi=(
        "fcrackzip"
    )

    echo -e "${b}[*] ${p}Menginstal depedensi yang diperlukan.${r}"
    sleep 3
  
    for depedensi in "${daftar_depedensi[@]}"; do
        echo -e "${b}[*] ${p}Menginstal ${depedensi}...${r}"
        sleep 3
        apt-get install "${depedensi}"
        echo -e "${h}[+] ${p}${depedensi} berhasil diinstal.${r}"
        sleep 1
    done

    chmod +x fcrackzip.sh

    echo ""
    echo -e "${p}[${c}info${p}] Semua depedensi yang diperlukan berhasil diinstal.${r}"
    sleep 1
    echo -e "${p}[${c}info${p}] Fcrackzip berhasil diinstal.${r}"
    sleep 1
    echo -e "${p}[${c}info${p}] Untuk menjalankan ketikkan perintah ${h}./fcrackzip.sh${r}"
    sleep 1
    echo ""
    exit 0
}

function instal_fcrackzip(){
    read -p $'\e[1;37mApakah Anda ingin menginstal alat Fcrackzip [iya/tidak]: ' nanya

    if [[ "${nanya}" == "iya" ]]; then
        cek_koneksi_internet
    elif [[ "${nanya}" == "tidak" ]]; then
        echo -e "${m}[-] ${p}Proses instalasi dibatalkan.${r}"
        exit 1
    else
        echo -e "${m}[-] Masukkan salah.${r}"
        instal_fcrackzip
    fi
}

instal_fcrackzip
