
# 提交修改，推到主分支
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
git add .
git commit -m "修改CPU占用过高的问题，界面会进一步美化"
git push -u origin master

echo '+++++++++++++++++++++++++++ commit successful ++++++++++++++++++++'

# 注意需要修改当前的版本号
echo '+++++++++++++++++++++++++++ pushing tags ++++++++++++++++++++'
git tag 1.4.5
git push --tags

echo '+++++++++++++++++++++++++++ pushing successful ++++++++++++++++++++'

# 检查库的语法完整性
echo '+++++++++++++++++++++++++++ spec lint ++++++++++++++++++++'
pod spec lint --allow-warnings

echo '+++++++++++++++++++++++++++ spec lint successful ++++++++++++++++++++'

# 提交仓库到本地和公共仓库
echo '+++++++++++++++++++++++++++ push spec ++++++++++++++++++++'
pod repo add GodEye https://github.com/Bogon/CCSpec
pod repo add GodEye https://github.com/CocoaPods/Specs
pod repo push GodEye GodEye.podspec --sources='https://github.com/Bogon/CCSpec.git, https://github.com/CocoaPods/Specs.git' --allow-warnings

echo '+++++++++++++++++++++++++++ push spec successful ++++++++++++++++++++'


