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
git clone --depth 1 https://github.com/destan19/OpenAppFilter && mvdir OpenAppFilter && cd luci-app-oaf/po && ln -s zh-cn zh_Hans && cd ../../

git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced

#netdata
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata && cd luci-app-netdata/po && ln -s zh-cn zh_Hans && cd ../../

#主题
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon

#adguardhome
svn export https://github.com/kiddin9/openwrt-adguardhome/trunk/luci-app-adguardhome
sed -i 's@.*AdGuardHome.yaml*@#&@g' ./*adguardhome/Makefile
sed -i 's/AdGuardHome.yaml/config\/AdGuardHome.yaml/g' ./*adguardhome/root/etc/config/AdGuardHome

#passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk ./ && rm -rf .svn && rm -rf .github
svn export https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall ./luci-app-passwall

#ssrplus
svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus
svn export https://github.com/coolsnowwolf/packages/trunk/net/redsocks2

#文件传输
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-filetransfer
svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-fs

#Turbo ACC 网络加速
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-turboacc && cd luci-app-turboacc/po && ln -s zh-cn zh_Hans && cd ../../
svn export https://github.com/coolsnowwolf/packages/trunk/net/dnsforwarder
svn export https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe

#访客网络
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-guest-wifi && cd luci-app-guest-wifi/po && ln -s zh-cn zh_Hans && cd ../../

#简易更新
svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-easyupdate && cd luci-app-easyupdate/po && ln -s zh-cn zh_Hans && cd ../../

#网络唤醒++
svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus && cd luci-app-wolplus/po && ln -s zh-cn zh_Hans && cd ../../

#openclash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile

#磁盘管理
svn export https://github.com/lisaac/luci-app-diskman/trunk/applications/luci-app-diskman
mkdir -p parted && wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O parted/Makefile

#实时流量监测
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-wrtbwmon && cd luci-app-wrtbwmon/po && ln -s zh-cn zh_Hans && cd ../../

#CPU 性能优化调节
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-cpufreq && cd luci-app-cpufreq/po && ln -s zh-cn zh_Hans && cd ../../

#释放内存
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-ramfree && cd luci-app-ramfree/po && ln -s zh-cn zh_Hans && cd ../../

#IP/MAC绑定
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-arpbind && cd luci-app-arpbind/po && ln -s zh-cn zh_Hans && cd ../../

sed -i 's/.\.\/.\./\$\(TOPDIR\)\/feeds\/luci/g' ./luci-app-*/Makefile

rm -rf ./*/.git &
rm -rf ./*/.gitattributes
rm -rf ./*/.svn &
rm -rf ./*/.github &
rm -rf ./*/.gitignore

exit 0
