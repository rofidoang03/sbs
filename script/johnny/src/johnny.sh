#!/bin/bash
# ------------------------------------------------------------
# + Alat      : Johnny
# + Deskripsi : Fcrackzip adalah (Deskripsi)
# + Pembuat   : Rofidoang03
# ------------------------------------------------------------
# + Github    : https://github.com/rofidoang03/sbs
# ------------------------------------------------------------

# variabel warna
b="\e[1;34m" # biru terang
m="\e[1;31m" # merah terang
p="\e[1;37m" # putih terang
c="\e[1;36m" # cyan terang
r="\e[;0m"   # reset

# fungsi mengecek apakah alat fcrackzip sudah terinstal apa belum
function cek_alat(){
    if ! command -v johnny >> /dev/null 2>&1; then
        echo -e "${m}[-] ${p}Alat Johnny belum diinstal.${r}"
        echo -e "${p}[${c}info${p}] Untuk menginstalnya ketikkan perintah '${c}sudo apt-get install johnny${p}'${r}"
    else
        jalankan_alat_johnny
    fi
}

jalankan_alat_johnny() {
  echo ""
  echo -e "${b}[*] ${p}Menjalankan alat Johnny...${r}"
  echo ""
  sleep 3
  johnny
  bash sbs.sh
}

jalankan_alat_johnny
