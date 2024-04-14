#!/bin/bash
# ---------------------------------------------------------------
# + Script      : instal.sh
# + Deskripsi   : instal.sh adalah script bash untuk menginstal 
#               : alat Fcrackzip secara otomatis.
# + Pembuat     : Rofidoang03
# ---------------------------------------------------------------
# + Github      : https://github.com/rofidoang03/sbs
# ---------------------------------------------------------------

function cek_koneksi_internet(){
    if ping -q -c 1 -W 1 google.com >/dev/null; then
        echo "[+] Anda memiliki koneksi internet."
        instal_depedensi
    else
        echo "[-] Anda tidak memiliki koneksi internet."
        sleep 1
        echo "[info] Pastikan Anda memiliki koneksi internet untuk menginstal alat Fcrackzip."
        exit 1
    fi
}

function instal_depedensi(){
    daftar_depedensi=(
        "wget"
        "fcrackzip"
    )

    echo ""
    echo "[*] Menginstal depedensi yang diperlukan."
    echo "-----------------------------------------"
    sleep 3
  
    for depedensi in "${daftar_depedensi[@]}"; do
        echo "[*] Menginstal ${depedensi}..."
        sleep 3
        apt-get install wget
        echo "[+] ${depedensi} berhasil diinstal."
        sleep 1
    done

    chmod +x fcrackzip.sh

    echo ""
    echo "[info] Semua depedensi yang diperlukan berhasil diinstal."
    sleep 1
    echo "[info] Fcrackzip berhasil diinstal."
    sleep 1
    echo "[info] Untuk menjalankan ketikkan perintah ./fcrackzip.sh"
    sleep 1
    echo ""
    exit 0
}

function instal_fcrackzip(){
    read -p "Apakah Anda ingin menginstal alat Fcrackzip [iya/tidak]: " nanya

    if [[ "${nanya}" == "iya" ]]; then
        cek_koneksi_internet
    elif [[ "${nanya}" == "tidak" ]]; then
        echo "[-] Proses instalasi dibatalkan."
        exit 1
    else
        echo "[-] Masukkan salah."
        instal_fcrackzip
    fi
}

instal_fcrackzip
