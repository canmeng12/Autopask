#!/bin/bash
function git_clone() {
  git clone --depth 1 $1 $2 || true
}
function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
}
function mvdir() {
  mv -n $(find $1/* -maxdepth 0 -type d) ./
  rm -rf $1
}

#应用过滤
git clone --depth 1 https://github.com/destan19/OpenAppFilter && mvdir OpenAppFilter
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata

git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon

svn export https://github.com/kiddin9/openwrt-adguardhome/trunk/luci-app-adguardhome
sed -i 's@.*AdGuardHome.yaml*@#&@g' ./*adguardhome/Makefile
sed -i 's/AdGuardHome.yaml/config\/AdGuardHome.yaml/g' ./*adguardhome/root/etc/config/AdGuardHome
#passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk ./
rm -rf .svn
rm -rf .github

svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-cpufreq
sed -i 's/.\.\/.\./\$\(TOPDIR\)\/feeds\/luci/g' ./luci-app-cpufreq/Makefile

svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-ramfree
sed -i 's/.\.\/.\./\$\(TOPDIR\)\/feeds\/luci/g' ./luci-app-ramfree/Makefile

svn export https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall ./luci-app-passwall
#ssrplus
svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus
svn export https://github.com/coolsnowwolf/packages/trunk/net/redsocks2

svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-filetransfer
sed -i 's/.\.\/.\./\$\(TOPDIR\)\/feeds\/luci/g' ./luci-app-filetransfer/Makefile
svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-fs

svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-turboacc
svn export https://github.com/coolsnowwolf/packages/trunk/net/dnsforwarder
svn export https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe
sed -i 's/.\.\/.\./\$\(TOPDIR\)\/feeds\/luci/g' ./luci-app-turboacc/Makefile

svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-guest-wifi
sed -i 's/.\.\/.\./\$\(TOPDIR\)\/feeds\/luci/g' ./luci-app-guest-wifi/Makefile

svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-easyupdate
svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus

svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile

rm -rf ./*/.git &
rm -rf ./*/.gitattributes
rm -rf ./*/.svn &
rm -rf ./*/.github &
rm -rf ./*/.gitignore

exit 0
