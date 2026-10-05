#!/usr/bin/env bash
# Downloads every image, video and font used by the Club Curated site from Wix
# into ./assets so the site is fully self-hosted.
#
#   bash get-assets.sh              # web-sized images (what the site needs)
#   bash get-assets.sh --originals  # also save the full-resolution originals to ./originals
#
# Safe to re-run: files that already exist are skipped.

cd "$(dirname "$0")" || exit 1
mkdir -p assets/img assets/video assets/fonts
M="https://static.wixstatic.com/media"
V="https://video.wixstatic.com/video"
F="https://static.wixstatic.com/ufonts"
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126 Safari/537.36"
fail=0

get() { # get <dest> <url> [fallback-url ...]
  local dest="$1"; shift
  if [ -s "$dest" ]; then echo "  have  $dest"; return 0; fi
  for url in "$@"; do
    if curl -fsSL --retry 3 -A "$UA" -o "$dest.part" "$url" && [ -s "$dest.part" ]; then
      mv "$dest.part" "$dest"; echo "  ok    $dest"; return 0
    fi
  done
  rm -f "$dest.part"; echo "  FAIL  $dest"; fail=$((fail+1)); return 1
}

echo "Images"
get assets/img/logo.png              "$M/9ed521_ed9c3e3dd4ca47c2928f6578ec52828d~mv2.png/v1/fill/w_486,h_136,al_c,q_85,usm_0.66_1.00_0.01/logo.png"
get assets/img/icon-instagram.png    "$M/11062b_cef3b719166a4815b446d4dcfcb6120d~mv2.png/v1/fill/w_78,h_78,al_c,q_85,usm_0.66_1.00_0.01/i.png"
get assets/img/icon-youtube.png      "$M/11062b_fe985b889c144b348eefc7bbc67018b4~mv2.png/v1/fill/w_78,h_78,al_c,q_85,usm_0.66_1.00_0.01/i.png"
get assets/img/icon-tiktok.png       "$M/11062b_3a1a34a22c10436caac05a4e0f6a876e~mv2.png/v1/fill/w_78,h_78,al_c,q_85,usm_0.66_1.00_0.01/i.png"
get assets/img/icon-whatsapp.png     "$M/11062b_a193068045064f4fa21b07cd12dae779~mv2.png/v1/fill/w_78,h_78,al_c,q_85,usm_0.66_1.00_0.01/i.png"
get assets/img/home-hero-poster.jpg  "$M/9ed521_c5fdb785d7114fa69f8d08459f9c3385f000.jpg/v1/fill/w_1920,h_285,al_b,q_80,usm_0.33_1.00_0.00/p.jpg"
get assets/img/home-1.png            "$M/9ed521_0538133761ed4e2abde9cda4eae6b3e1~mv2.png/v1/fill/w_766,h_1022,al_c,q_90,usm_0.66_1.00_0.01/1.png"
get assets/img/home-2.png            "$M/9ed521_30db2bba71d244ef93f5b03a773febdf~mv2.png/v1/fill/w_766,h_1022,al_c,q_90,usm_0.66_1.00_0.01/2.png"
get assets/img/studios-dj.png        "$M/9ed521_59717e74bbfb4f8d93997539caf48dd8~mv2.png/v1/crop/x_0,y_458,w_3024,h_3117/fill/w_906,h_934,al_c,q_90,usm_0.66_1.00_0.01/s.png"
get assets/img/studios-production.jpg "$M/9ed521_ee75ede74e6e4bfabe1030379dbe6541~mv2.jpg/v1/fill/w_886,h_934,al_c,q_85,usm_0.66_1.00_0.01/s.jpg"
get assets/img/dj-hero-poster.jpg    "$M/9ed521_26c69faf58f34dada13c07b235904d6ff000.jpg/v1/fill/w_1920,h_282,al_c,q_80,usm_0.33_1.00_0.00/p.jpg"
get assets/img/dj-main.png           "$M/9ed521_0fe913248f6e412ea7a424edded7d48e~mv2.png/v1/fill/w_900,h_1106,al_c,q_90,usm_0.66_1.00_0.01/d.png"
get assets/img/dj-gallery-1.png      "$M/9ed521_cc8f665824e0426ca92e1715f89b09fe~mv2.png/v1/fill/w_750,h_1000,q_90/g.png"
get assets/img/dj-gallery-2.png      "$M/9ed521_3deb4dba5d2441f283c7631113896564~mv2.png/v1/fill/w_750,h_1000,fp_0.19_0.25,q_90/g.png"
get assets/img/dj-gallery-3.png      "$M/9ed521_59717e74bbfb4f8d93997539caf48dd8~mv2.png/v1/fill/w_750,h_1000,q_90/g.png"
get assets/img/dj-gallery-4.png      "$M/9ed521_ec4d590d481e47adb4e118d82be39b63~mv2.png/v1/fill/w_750,h_1000,fp_0.43_0.42,q_90/g.png"
get assets/img/dj-gallery-5.png      "$M/9ed521_4eaed6cb873242d7ba97ecbb08cdf4cd~mv2.png/v1/fill/w_750,h_1000,q_90/g.png"
get assets/img/dj-gallery-6.png      "$M/9ed521_d8783da69861423997b4017e52221484~mv2.png/v1/fill/w_750,h_1000,fp_0.15_0.4,q_90/g.png"
get assets/img/mp-banner.png         "$M/9ed521_0878b6fda46445ad8ed7bfc747598bb6~mv2.png/v1/fill/w_1920,h_231,al_c,q_85/b.png" \
                                     "$M/9ed521_0878b6fda46445ad8ed7bfc747598bb6~mv2.png/v1/fill/w_756,h_91,al_c,q_85/b.png"
get assets/img/mp-main.png           "$M/9ed521_8728ce02ea3b4b29b37e7e2d1ff20ee5~mv2.png/v1/fill/w_874,h_1165,al_c,q_90/m.png"
get assets/img/about-rigsounds.png   "$M/9ed521_aada634a1d6c4f9aa5209fb26dc3f4d9~mv2.png/v1/crop/x_97,y_632,w_854,h_135/fill/w_492,h_78,al_c,q_85,usm_0.66_1.00_0.01/2.png"
get assets/img/about-absolut.png     "$M/9ed521_0cac3575c9bf448396e823e349236d6c~mv2.png/v1/crop/x_197,y_587,w_682,h_158/fill/w_388,h_90,al_c,q_85,usm_0.66_1.00_0.01/1.png"
get assets/img/about-pirate.png      "$M/9ed521_2335a12f861a401cb22779d29a67e663~mv2.png/v1/crop/x_390,y_417,w_3421,h_503/fill/w_492,h_68,al_c,q_85,usm_0.66_1.00_0.01/p.png"

echo "Videos"
# Home hero: 720p keeps the file small for free hosts; falls back to 1080p (~39 MB) then 480p.
get assets/video/home-hero.mp4 "$V/9ed521_c5fdb785d7114fa69f8d08459f9c3385/720p/mp4/file.mp4" \
                               "$V/9ed521_c5fdb785d7114fa69f8d08459f9c3385/1080p/mp4/file.mp4" \
                               "$V/9ed521_c5fdb785d7114fa69f8d08459f9c3385/480p/mp4/file.mp4"
get assets/video/dj-hero.mp4   "$V/9ed521_26c69faf58f34dada13c07b235904d6f/480p/mp4/file.mp4"

echo "Fonts"
get assets/fonts/cc-1.woff2 "$F/0fa3ce_54520138211847fe83a6c676ef8b5734/woff2/file.woff2"
get assets/fonts/cc-2.woff2 "$F/0fa3ce_e5eb1d10e55241b483ba19d71ea06a4a/woff2/file.woff2"
get assets/fonts/cc-3.woff2 "$F/0fa3ce_4554f95a8f384a2abcd1019745dff546/woff2/file.woff2"
get assets/fonts/cc-4.woff2 "$F/0fa3ce_52c592d00f9a48cc870a422025b4ed28/woff2/file.woff2"
get assets/fonts/cc-5.woff2 "$F/0fa3ce_763cc4d232dc4947be1ecb348a7487dc/woff2/file.woff2"

if [ "$1" = "--originals" ]; then
  echo "Originals (full resolution)"
  mkdir -p originals
  get originals/logo.png               "$M/9ed521_ed9c3e3dd4ca47c2928f6578ec52828d~mv2.png"
  get originals/home-1.png             "$M/9ed521_0538133761ed4e2abde9cda4eae6b3e1~mv2.png"
  get originals/home-2.png             "$M/9ed521_30db2bba71d244ef93f5b03a773febdf~mv2.png"
  get originals/dj-suite.png           "$M/9ed521_59717e74bbfb4f8d93997539caf48dd8~mv2.png"
  get originals/production-suite.jpg   "$M/9ed521_ee75ede74e6e4bfabe1030379dbe6541~mv2.jpg"
  get originals/dj-main.png            "$M/9ed521_0fe913248f6e412ea7a424edded7d48e~mv2.png"
  get originals/dj-gallery-1.png       "$M/9ed521_cc8f665824e0426ca92e1715f89b09fe~mv2.png"
  get originals/dj-gallery-2.png       "$M/9ed521_3deb4dba5d2441f283c7631113896564~mv2.png"
  get originals/dj-gallery-4.png       "$M/9ed521_ec4d590d481e47adb4e118d82be39b63~mv2.png"
  get originals/dj-gallery-5.png       "$M/9ed521_4eaed6cb873242d7ba97ecbb08cdf4cd~mv2.png"
  get originals/dj-gallery-6.png       "$M/9ed521_d8783da69861423997b4017e52221484~mv2.png"
  get originals/mp-banner.png          "$M/9ed521_0878b6fda46445ad8ed7bfc747598bb6~mv2.png"
  get originals/mp-main.png            "$M/9ed521_8728ce02ea3b4b29b37e7e2d1ff20ee5~mv2.png"
  get originals/rigsounds.png          "$M/9ed521_aada634a1d6c4f9aa5209fb26dc3f4d9~mv2.png"
  get originals/absolut.png            "$M/9ed521_0cac3575c9bf448396e823e349236d6c~mv2.png"
  get originals/pirate.png             "$M/9ed521_2335a12f861a401cb22779d29a67e663~mv2.png"
  get originals/home-hero-1080p.mp4    "$V/9ed521_c5fdb785d7114fa69f8d08459f9c3385/1080p/mp4/file.mp4"
fi

echo
if [ "$fail" -eq 0 ]; then echo "All assets downloaded. Open index.html to view the site."
else echo "$fail file(s) failed - re-run this script to retry just those."; fi
