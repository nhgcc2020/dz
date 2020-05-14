/*
* 微信端页面 版本号 未加入控制
* modified last 2017-8-3
* 未解决 css里引用字体不能加上版本号 只能手工添加(如果字体更新频繁)
 */

//引入gulp和gulp插件
var gulp = require('gulp'),
    runSequence = require('run-sequence'),
    rev = require('gulp-rev'),
    uglify = require("gulp-uglify"),
    revCollector = require('gulp-rev-collector');

//定义css、js源文件路径
var cssSrc = 'resources/**/*.css',
    wechatjsSrc = 'wechat/js/*.js',
    wechatcssSrc = 'wechat/css/*.css',
    jsSrc = 'resources/**/*.js';


//CSS生成文件hash编码并生成 rev-manifest.json文件名对照映射
gulp.task('revCss', function(){
    return gulp.src([cssSrc,wechatcssSrc])
        .pipe(rev())
        .pipe(rev.manifest())
        .pipe(gulp.dest('rev/css'));
});


//js生成文件hash编码并生成 rev-manifest.json文件名对照映射
gulp.task('revJs', function(){
    return gulp.src([jsSrc,wechatjsSrc])
        .pipe(rev())
        .pipe(rev.manifest())
        .pipe(gulp.dest('rev/js'));
});


//Html替换css、js文件版本
gulp.task('shareHtml', function () {
    return gulp.src(['rev/**/*.json', 'ordershare/*.html'])
        .pipe(revCollector())
        .pipe(gulp.dest('ordershare'));
});
gulp.task('printHtml', function () {
    return gulp.src(['rev/**/*.json', 'print/*.html'])
        .pipe(revCollector())
        .pipe(gulp.dest('print'));
});
gulp.task('loginHtml', function () {
    return gulp.src(['rev/**/*.json', 'login.jsp'])
        .pipe(revCollector())
        .pipe(gulp.dest('.'));
});
gulp.task('registerHtml', function () {
    return gulp.src(['rev/**/*.json', 'register.jsp'])
        .pipe(revCollector())
        .pipe(gulp.dest('.'));
});
gulp.task('frameHtml', function () {
    return gulp.src(['rev/**/*.json', 'frame/**/*.html'])
        .pipe(revCollector())
        .pipe(gulp.dest('frame'));
});
gulp.task('revHtml', function () {
    return gulp.src(['rev/**/*.json', 'WEB-INF/jsp/**/*.jsp'])
        .pipe(revCollector())
        .pipe(gulp.dest('WEB-INF/jsp'));
});
gulp.task('minify-js', function () {
    gulp.src('resources/**/*.js') // 要压缩的js文件
        .pipe(uglify())  //使用uglify进行压缩,更多配置请参考：
        .pipe(gulp.dest('dist/js')); //压缩后的路径
});

//开发构建
gulp.task('dev', function (done) {
    condition = false;
    runSequence(
        ['revCss'],
        ['revJs'],
        ['revHtml'],
        done);
});
gulp.task('print', function (done) {
    condition = false;
    runSequence(
        ['revCss'],
        ['revJs'],
        ['printHtml'],
        done);
});
gulp.task('share', function (done) {
    condition = false;
    runSequence(
        ['revCss'],
        ['revJs'],
        ['shareHtml'],
        done);
});
gulp.task('login', function (done) {
    condition = false;
    runSequence(
        ['revCss'],
        ['revJs'],
        ['loginHtml'],
        done);
});
gulp.task('register', function (done) {
    condition = false;
    runSequence(
        ['revCss'],
        ['revJs'],
        ['registerHtml'],
        done);
});
gulp.task('frame', function (done) {
    condition = false;
    runSequence(
        ['revCss'],
        ['revJs'],
        ['frameHtml'],
        done);
});
//改变相应文件之后自动进行更新版本号 个人开发可以使用
// gulp.task('watch', function () {
//     gulp.watch([
//         cssSrc,
//         jsSrc,
//         'webapp/**/*.jsp'
//     ], ['dev']);
// });

//下几个请分开执行 请勿全不放开
// gulp.task('default', ['frame']);
gulp.task('default', ['dev','print','share','login','register','frame']);
// gulp.task('default', ['print','share']);
