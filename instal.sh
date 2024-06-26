#!/bin/bash
# ---------------------------------------------------------------
# + Script      : instal.sh
# + Deskripsi   : instal.sh adalah script bash untuk menginstal 
#               : SBS secara otomatis.
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


# fungsi untuk mengecek apakah kita memiliki koneksi internet atau tidak 
function cek_koneksi_internet(){
    echo -e "${b}[*] ${p}Mengecek koneksi internet Anda...${r}"
    sleep 3
    if ping -q -c 1 -W 1 google.com >/dev/null; then
        echo -e "${h}[+] ${p}Anda memiliki koneksi internet.${r}"
        instal_depedensi
    else
        echo -e "${m}[-] ${p}Anda tidak memiliki koneksi internet.${r}"
        sleep 1
        echo -e "${p}[${c}info${p}] Pastikan Anda memiliki koneksi internet untuk menginstal alat Fcrackzip.${r}"
        exit 1
    fi
}

# fungsi untuk menginstal depedensi yang diperlukan 
function instal_depedensi(){
    daftar_depedensi=(
        "fcrackzip"
        "aircrack-ng"
    )

    echo -e "${b}[*] ${p}Menginstal depedensi yang diperlukan.${r}"
    sleep 3

    # menginstal depedensi yang diperlukan menggunakan perulangan for
    for depedensi in "${daftar_depedensi[@]}"; do
        echo -e "${b}[*] ${p}Menginstal ${depedensi}...${r}"
        sleep 3
        apt-get install "${depedensi}"
        echo -e "${h}[+] ${p}${depedensi} berhasil diinstal.${r}"
        sleep 1
    done

    # memberikan izin eksekusi pada script fcrackzip.sh
    chmod +x sbs.sh

    echo ""
    echo -e "${p}[${c}info${p}] Semua depedensi yang diperlukan berhasil diinstal.${r}"
    sleep 1
    echo -e "${p}[${c}info${p}] SBS berhasil diinstal.${r}"
    sleep 1
    echo -e "${p}[${c}info${p}] Untuk menjalankan ketikkan perintah ${h}./sbs.sh${r}"
    sleep 1
    echo ""
    exit 0
}

# fungsi untuk menginstal alat aircrack-ng 
function instal_sbs(){
    clear    
    read -p $'\e[1;37mApakah Anda ingin menginstal SBS [iya/tidak]: ' nanya

    if [[ "${nanya}" == "iya" ]]; then
        cek_koneksi_internet
    elif [[ "${nanya}" == "tidak" ]]; then
        echo -e "${m}[-] ${p}Proses instalasi dibatalkan.${r}"
        exit 1
    else
        echo -e "${m}[-] Masukkan salah.${r}"
        instal_sbs
    fi
}

# memanggil fungsi instal sbs
instal_sbs
