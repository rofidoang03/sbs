#!/bin/bash
# ------------------------------------------------------------
# + Alat      : Aircrack-ng
# + Deskripsi : Aircrack-ng adalah yang digunakan untuk 
#             : membobol kunci WPA/WPA2 yang terdapat dalam
#             : file handshake.
# + Pembuat   : Rofidoang03
# ------------------------------------------------------------
# + Github    : https://github.com/rofidoang03/sbs
# ------------------------------------------------------------

# variabel warna
b="\e[1;34m" # biru terang
m="\e[1;31m" # merah terang
h="\e[1;32m" # hijau terang
p="\e[1;37m" # putih terang
c="\e[1;36m" # cyan terang
r="\e[;0m"   # reset

# membersihkan layar terminal
    clear


# fungsi mengecek apakah alat aircrack-ng sudah terinstal apa belum
function cek_alat(){
    if ! command -v aircrack-ng >> /dev/null 2>&1; then
        echo -e "${m}[-] ${p}Alat Aircrack-ng belum diinstal.${r}"
        echo -e "${p}[${c}info${p}] Untuk menginstalnya ketikkan perintah '${c}sudo apt-get install aircrack-ng${p}'${r}"
    else
        pilih_file_handshake
    fi
}

function banner(){

    echo -e ""
    echo -e "${p}[--------------------------------------------------------------]"
        echo -e "${p}[${c}--${p}]--------------------------------------------------------[${c}--${p}]${r}"
        echo -e "${p}[${c}--${p}]                     Aircrack-ng                        [${c}--${p}]${r}"
    echo -e "${p}[${c}--${p}]              ${c}Dibuat oleh: ${m}Rofi (Fixploit)              ${p}[${c}--${p}]${r}"
    echo -e "${p}[${c}--${p}]                      ${c}Version: ${m}1.0                      ${p}[${c}--${p}]${r}"
    echo -e "${p}[${c}--${p}]  ${c}Ikuti Saya di Github: ${m}https://github.com/rofidoang03  ${p}[${c}--${p}]${r}"
    echo -e "${p}[${c}--${p}]--------------------------------------------------------[${c}--${p}]${r}"
    echo -e "${p}[--------------------------------------------------------------]"
    echo -e "${r}"
}

# memanggil fungsi banner
banner

# fungsi untuk memilih file handshake yang akan di crack
function pilih_file_handshake(){

    read -p $'\e[1;37mMasukkan nama file handshake: ' file_handshake
    if [[ ! -f "${file_handshake}" ]]; then
        echo -e "${m}[-] ${p}File handshake '${m}${file_zip}${p}' tidak ditemukan.${r}"
        pilih_file_handshake
    elif [[ -f "${file_handshake}" && "${file_handshake##*.}" != "cap" ]]; then
        echo -e "${m}[-] ${p}File '${m}${file_handshake}${p}' bukan file handshake.${r}"
        pilih_file_handshake
    else
        echo -e "${h}[+] ${p}File handshake '${h}${file_handshake}${p}' ditemukan.${r}"
        pilih_file_wordlist
    fi
}

# fungsi untuk memilih file wordlist
function pilih_file_wordlist(){
    read -p $'\e[1;37mMasukkan nama file wordlist: ' file_wordlist
    if [[ ! -f "${file_wordlist}" ]]; then
        echo -e "${m}[-] ${p}File wordlist '${m}${file_wordlist}${p}' tidak ditemukan.${r}"
        pilih_file_wordlist
    else
        echo -e "${h}[+] ${p}File wordlist '${h}${file_wordlist}${p}' ditemukan.${r}"

        # jumlah password yang terdapat dalam file wordlist.
        jumlah_password=$(wc -l < "${file_wordlist}")

        echo ""
        echo -e "${p}[${c}info${p}] Daftar informasi proses cracking${r}"
        echo ""
        echo -e "${h}[+] ${p}File handshake: ${file_handshake}${r}"
        echo -e "${h}[+] ${p}File wordlist: ${file_wordlist}${r}"
        echo -e "${b}[*] ${p}Menghitung jumlah password${r}"
        echo -e "${h}[+] ${p}Jumlah password yang ingin dicoba: ${jumlah_password}${r}"
        echo ""

        crack_the_password
    fi
}

# fungsi crack kata sandi file handshake
function crack_the_password(){
    read -p $'\e[1;37mApakah Anda ingin memulai proses cracking [iya/tidak]: ' nanya
    if [[ "${nanya}" == "iya" ]]; then
        echo ""
        echo -e "${b}[*] ${p}Menjalankan alat Aircrack-ng...${r}"
        echo ""
        aircrack-ng -a2 -w "${file_wordlist}" "${file_handshake}"
        echo ""
        echo -e "${p}[${c}info${p}] Proses cracking selesai.${r}"
        read -p $'\e[1;37m[\e[1;36minfo\e[1;37m] Tekan Enter untuk melanjutkan...\e[0m'
                exit 0
    elif [[ "${nanya}" == "tidak" ]]; then
        echo -e "${m}[-] ${p}Proses cracking dibatalkan.${r}"
                exit 1
    else
        echo -e "${m}[-] ${p}Masukkan salah.${r}"
        crack_the_password
    fi
}

# memanggil fungsi cek alat
cek_alat
