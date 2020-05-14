<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>注册账号</title>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <style>
        body,html,.shark_contant{
            height:100%;
        }
        .shark_contant{
            max-width:640px;
            margin: 0px auto;
            background: #dc3d42;
            padding-bottom: 10px;
            overflow: scroll;
        }
        input[type="checkbox"]{
            display: none;
        }
        input[type="checkbox"]+label {
            display: inline-block;
            width: auto;
            margin-top: 10px;
            margin-left: 5px;
            text-align: left;
            -webkit-box-sizing: border-box;
        }
        label::before {
            content: "";
            display: inline-block;
            width: 15px;
            height: 15px;
            background: #EEE;
            vertical-align: middle;
            -webkit-border-radius: 50%;
            margin-right: 5px;
            -webkit-box-sizing:border-box;
        }
        input[type="checkbox"]:checked+label::before{
            background-color: #2e8ae6;
            border:3px #EEEEEE solid;
        }
        .copyright_text {
            text-align: center;
            color: #fff;
            margin-top: 35px;
            width: 100%;
            font-size: 12px;
            padding:0px;
            margin-bottom: 0px;
            line-height:15px;
            font-family: '微软雅黑',arial,'宋体' ;
        }
        .shark_contant_contant{
            position: absolute;
            top:0px;
            height:100%;
            left:0px;
            width:100%;
            background: #fff;
            z-index:999;
            overflow: hidden;
            display: none;
            padding:30px 15px;
            box-sizing: border-box;
        }
        #yonghuyinsi,#fuwutiaokuan{
            height:100%;
            width:100%;
            overflow: scroll;
            box-sizing: border-box;
            display: none;
        }
        #yonghuyinsi h1,#fuwutiaokuan h1{
            font-size: 14px;
            color: #666;
            text-indent: 2rem;
            line-height:24px;
            font-weight:normal;
        }
        #yonghuyinsi h2,#fuwutiaokuan h2{
            font-size: 14px;
            color: #666;
            line-height:22px;
            font-weight:normal;
        }
        #yonghuyinsi p,#fuwutiaokuan p{
            font-size: 12px;
            color: #999;
            text-indent: 1rem;
            line-height:20px;
            font-weight:normal;
        }
        #yonghuyinsi h3,#fuwutiaokuan h3{
            font-size: 12px;
            color: #999;
            line-height:22px;
            font-weight:normal;
            text-indent: 2rem;
        }
        .shark_contant_close{
            position: absolute;
            display: block;
            height:30px;
            width:30px;
            background:url("../../../images/close.png") center no-repeat #fff;
            border:1px solid #e4e4e4;
            z-index: 9999;
            top:10px;
            right:10px;
        }
    </style>
</head>
<body>

<div class="shark_contant">

    <div class="shark_contant_contant">
        <div id="yonghuyinsi">
            <h1>上海仁石科技有限公司（为便于用户理解，以下文中简称”易对账“）注重您个人隐私的保护， 隐私权保护声明系本网站保护用户个人隐私的承诺，您在使用仁石之前请务必阅读并同意本隐私权保护规则的条款。 鉴于网络的特性，本网站将无可避免地与您产生直接或间接的互动关系，有时候我们需要某些信息才能为您提供您请求的服务， 本隐私权声明解释了这些情况下的数据收集和使用情况。如果你对我们的隐私政策有任何疑问，请通过邮箱ceo@yiduizhang.com与我们联系。 作为本公司服务的正常操作程序的一部分，本公司收集、使用并（在一些情况下）向第三方披露有关您的资料。 本隐私权保护规则制约本公司收集的有关您的资料及您对本公司提供给您的资料之使用。您以任何方式使用服务的行为， 无论您是否已经成为本公司的注册用户，均表示您接受本隐私权保护规则及用户协议，即为明示同意本公司按本隐私权保护规则所述方式使用和披露您的个人资料。 经您自行选择注册为易对账用户， 则本隐私权保护规则被纳入易对账用户协议之中，并受该协议的条款制约。以下为本网站对用户个人信息所采取的收集、使用和保护政策，请您务必仔细阅读：</h1>
            <h2>一、关于用户的重要说明</h2>
            <p>易对账非常重视对用户个人信息的安全性和保护。未经用户事先同意，易对账不会使用用户的个人信息， 也不会向任何第三方透露可识别的信息，除非是为了向用户提供服务之必要。经由用户同意， 易对账可以搜集用户的个人信息，但用户有权拒绝易对账进一步搜集其个人信息， 有权审阅或要求易对账删除该用户的个人信息。</p>
            <h2>二、易对账信息的收集和使用</h2>
            <p>注册时，易对账网站由对仁石或其关联公司所运行的各个网站和网页（合称易对账网站）构成要求提交例如电子邮件地址等信息， 以此来鉴定会员资格并向会员发送与易对账网站服务有关的邮件通知。除此之外，易对账网站也会收集例如但不仅限于如下的资料： 年龄，昵称，兴趣爱好，性别，教育程度，职业，联系方式等，目的是促进会员之间的联系与交流。 除了个人信息以外， 易对账网站会收集一些与会员及游客身份无关的信息，包括IP地址，访问时间，浏览器类型等。这些信息将用于网站管理， 行为跟踪以及提高网站的服务质量。这些和个人隐私无关的信息可能会分享给第三方公司，进而为我们的会员提供更多相关的服务和广告。 记录用户的IP地址也是出于安全和监控的目的。 在易对账的网络里，会员档案资料包括照片和姓名都是公开的，以此促进用户之间的互助互动。 电子邮件的用途体现在邀请新朋友加入易对账，添加用户到会员的个人网络，接收与服务有关的邮件通知， 会员之间可以使用易对账提供的服务进行在线交流。 我们可能会通过会员的电子邮件地址来向会员传递有关本站的更新， 新闻以及与服务相关的动态。我们将通过您的IP地址来收集非个人化的信息，例如您的浏览器性质、操作系统种类、 给您提供接入服务的ISP的域名等，以优化在您计算机屏幕上显示的页面。通过收集上述信息，我们亦进行客流量统计，从而改进网站的管理和服务。</p>
            <h2>三、对未注册网站用户的邀请</h2>
            <p>易对账会员可以通过我们的系统向好友们发送邀请加入易对账网站。 易对账网站将储存会员提供的手机或电子邮件地址以便于接收者可以进入发送者的好友列表， 同时也方便再次发送邀请提醒。易对账不会出售此类电子邮件地址或者向他们发送除邀请及邀请提醒外的邮件内容。</p>
            <h2>四、Cookies的使用</h2>
            <p>Cookies是指一种技术，当使用者访问设有Cookies装置的本网站时， 易对账服务器会自动发送Cookies至您的浏览器内，并储存到您的电脑硬盘内， 此Cookies便负责记录日后您到访本网站的种种活动、个人资料、浏览习惯、消费习惯甚至信用记录。 运用Cookies技术，易对账能够为您提供更加周到的个性化服务。我们将会运用Cookies追访您的喜好， 从而向您提供感兴趣的信息资料或储存密码，以便您造访本网站时不必每次重复输入密码。 您可以接受或拒绝 Cookie。大多数 Web 浏览器会自动接受 Cookie，但您通常可根据自己的需要来修改浏览器的设置以拒绝 Cookie。 如果选择拒绝 Cookie，那么您可能无法完全体验所访问的易对账服务或网站的互动功能。</p>
            <h2>五、安全性</h2>
            <p>您的资料存储于本公司租赁的阿里巴巴云计算公司位于国内的机房服务器中。 本公司采用行业标准努力以维护您的个人资料的隐私性，如包括“防火墙”及安全套接层协议（Secure Socket Layer）。 出租方阿里巴巴云计算公司并受与易对账近似的隐私规定的约束，且不存在超出本协议约定范围使用您的资料的行为。 然而，互联网上并不存在“絶对的安全”。互联网上的内容或第三方提供的内容可能对您的系统有害。 本公司强烈鼓励使用病毒防护软件、个人防火墙等以保卫及保护您的系统。</p>
            <h2>六、控制您的密码</h2>
            <p>您须对使用您的注册手机号码和密码所采取的一切行动（包括费用）负责。因此，本公司建议您不要向任何第三方披露您的易对账服务密码。 如果您选择与第三方共用您的注册电子邮件地址或您的资料以获得额外服务，则您同意对您使用您的手机号码和密码所采取的一切行动负责， 而且您须审阅该第三方的隐私权保护规则。如果您对您的密码失去控制， 您可能对您的个人资料失去实质性的控制，并可能因他人以您的名义采取的有法律约束力的行动而受到制约或承担责任。</p>
            <h2>七、易对账会员信息的公开情况</h2>
            <p>除了在此隐私政策中所描述的情况外，易对账不会向任何第三方泄漏会员的个人身份资料，以下几种情况例外：</p>
            <h3>（1）当法律法规要求易对账对某个执法程序作出回应时；</h3>
            <h3>（2）需要履行易对账的服务条款以及保护网站的权利时；</h3>
            <h3>（3）当用户和会员的安全需要得到保护时。易对账保留在特定情况下将用户信息转交给服务继承者的权利，如易对账被收购或资产转移等。</h3>
            <h2>八、与网站联系</h2>
            <p>如果你有与隐私保护，政策实施或网站操作有关的问题，请将意见或建议发送至我们的邮箱: ceo@duizhangtong.com</p>
            <h2>九、关于免责</h2>
            <p>就下列相关事宜的发生，易对账不承担任何法律责任：</p>
            <h3>9.1、易对账根据法律规定或相关政府的要求提供您的个人信息；</h3>
            <h3>9.2、由于您将用户密码告知他人或与他人共享注册帐户，由此导致的任何个人信息的泄漏，或其他非因易对账原因导致的个人信息的泄漏；</h3>
            <h3>9.3、任何第三方根据易对账各服务条款及声明中所列明的情况使用您的个人信息，由此所产生的纠纷；</h3>
            <h3>9.4、任何由于黑客攻击、电脑病毒侵入或政府管制而造成的暂时性网站关闭；</h3>
            <h3>9.5、因不可抗力导致的任何后果；</h3>
            <h3>9.6、易对账在各服务条款及声明中列明的使用方式或免责情形 。</h3>
            <h2>十、关于隐私政策的更新</h2>
            <p>易对账会不时更新本隐私权声明。声明公告生效后，会员即需遵守。</p>
        </div>
        <div id="fuwutiaokuan">
            <h1>易对账服务条款（下称"服务条款"）是上海仁石科技有限公司 (下称“仁石科技”)与您就易对账服务等相关事项所订立的有效合约。 您通过盖章、网络页面点击确认或以其他方式选择接受本服务条款，即表示您与仁石科技已达成协议并同意接受本服务条款的全部约定内容。 在接受本服务条款之前，请您仔细阅读本服务条款的全部内容。如果您对本服务条款的相关内容有疑问的，请通过询问仁石科技，仁石科技将向您解释条款内容。 如果您不同意本服务条款的任意内容，或者无法准确理解仁石科技对条款的解释，请不要进行后续操作。</h1>
            <h2>一、定义及解释</h2>
            <p>1、“易对账服务”：指向您提供的在www.yiduizhang.com网站和/或乙方提供技术支持的其他联盟成员的相关服务和/或界面上所展示的易对账服务以及相关的技术及网络支持服务。</p>
            <p>2、“服务费”：是您为购买“易对账服务”支付的费用，具体数额将在您订购页面予以列明公示，或者由 “易对账服务销售合同”约定。</p>
            <p>3、“服务费”的续费：您为在约定服务到期后持续使用“易对账服务”，在约定服务到期前进行服务续费。 您在每次续费前有义务再次认真阅读并确保完全理解届时www.yiduizhang.com网站下《易对账服务条款》的各项规定， 在全部同意该条款所有内容后进行续费，您每次续费行为将视为已阅读并完全理解《易对账服务条款》最新版且承诺遵守约定。
            </p>
            <h2>二、服务内容</h2>
            <p>1、 本条款中“服务”特指易对账服务。</p>
            <p>2、 仁石科技提供的易对账服务必须符合本服务条款的约定。</p>
            <h2>三、续费</h2>
            <p>1、服务期满双方愿意继续合作的，您至少应在服务期满前7天内支付续费款项，以使服务得以继续进行。如续费时仁石科技对易对账服务体系、名称或价格进行调整的， 双方同意按照届时有效的新的服务体系、名称或价格履行，但调整前您已经支付的款项不受影响。</p>
            <p>2、 仁石科技保留在您未按照约定支付全部费用之前不向您提供服务和/或技术支持，或者终止服务和/或技术支持的权利。</p>
            <h2>四、您的权利与义务</h2>
            <p>1、您同意遵守本服务条款以及服务展示页面的相关管理规范及流程。您了解上述协议及规范等的内容可能会不时变更。 如本服务条款的任何内容发生变动，仁石科技应通过提前30天在www.yiduizhang.com的适当版面公告向您提示修改内容。 如您不同意仁石科技对服务条款相关条款所做的修改，您有权停止使用易对账服务，此等情况下，仁石科技应与您进行服务费结算（如有）， 并且您需要自行备份业务数据。如您继续使用易对账服务，则视为您接受仁石科技对服务条款相关条款所做的修改。</p>
            <p>2、 您应按照仁石科技在www.yiduizhang.com网站公示的提示及本服务条款的约定支付相应服务费用。</p>
            <p>3、 您承诺：</p>
            <h3>(1）如果您使用易对账服务进行的经营活动需要获得国家有关部门的许可或批准的， 应获得该有关的许可或批准。例如您从事新闻、出版、教育、医疗保健、药品和医疗器械等， 同时您理解并认可，以上列举并不能穷尽您进行经营活动需要获得国家有关部门的许可或批准的全部类型， 您应获得有关的许可或批准，并应符合国家及地方不时颁布相关法律法规之要求；</h3>
            <h3>(2）若仁石科技的服务涉及第三方软件之许可使用的，您同意遵守相关的许可协议的约束；</h3>
            <h3>(3)不利用易对账服务提供的资源和服务上传（Upload）、下载（download）、储存、发布如下信息或者内容，不为他人发布该等信息提供任何便利： ①违反国家规定的政治宣传和/或新闻信息； ②涉及国家秘密和/或安全的信息； ③封建迷信和/或淫秽、色情、下流的信息或教唆犯罪的信息； ④博彩有奖、赌博游戏、“私服”、“外挂”等非法互联网出版活动； ⑤违反国家民族和宗教政策的信息；⑥妨碍互联网运行安全的信息； ⑦侵害他人合法权益的信息和/或其他有损于社会秩序、社会治安、公共道德的信息或内容； ⑧其他违反法律法规、部门规章或国家政策的内容。</h3>
            <h3>(4)不进行任何破坏或试图破坏网络安全的行为（包括但不限于钓鱼，黑客，网络诈骗，网站或空间中含有或涉嫌散播：病毒、木马、恶意代码， 及通过虚拟服务器对其他网站、服务器进行涉嫌攻击行为如扫描、嗅探、ARP欺骗、DOS等）；</h3>
            <h3>(5)不从事其他违法、违规或违反易对账服务条款的行为。</h3>
            <h3>(6)如仁石科技发现您违反上述条款的约定，有权根据情况采取相应的处理措施，包括但不限于立即终止服务、中止服务或删除相应信息等。 如果第三方机构或个人对您提出质疑或投诉，仁石科技将通知您，您有责任在规定时间内进行说明并出具证明材料， 如您未能提供相反证据或您逾期未能反馈的，仁石科技将采取包括但不限于立即终止服务、中止服务或删除相应信息等处理措施。 因您未及时更新联系方式或联系方式不正确而致使未能联系到您的，亦视为您逾期未能反馈。</h3>
            <p>4、 您使用“易对账服务”进行商务活动所引起的一切法律纠纷均与仁石科技无关。</p>
            <p>5、 您对自己使用易对账服务过程产生的数据以及进入和管理易对账服务上各类产品与服务的账号、密码的完整性和保密性负责。 因您维护不当或保密不当致使上述数据、口令、密码等丢失或泄漏所引起的一切损失和后果均由您自行承担。</p>
            <p>6、 如您违反本合同规定的任何条款，仁石科技有权拒绝向您提供易对账服务，并终止本合同。您已支付的“服务费”不予退还， 同时仁石科技有进一步追究客户法律责任的权利。</p>
            <h2>五、仁石科技的权利和义务</h2>
            <p>1、仁石科技应按照合同约定提供服务,保证服务可持续运行及数据安全。</p>
            <p>2、仁石科技已获得必要的许可和授权，有权按本合同约定为客户提供“易对账服务”。</p>
            <p>3、仁石科技在客户使用易对账产品的服务期内在服务器上保存客户的信息，并在客户终止服务使用后永久删除。</p>
            <p>4、仁石科技不向其他任何第三方保证和承诺客户提交的网页和信息符合注册标准，客户自行对其易对账服务提供的内容、产品、服务等承担全部责任。</p>
            <p>5、仁石科技有权随时删除含有任何危害国家安全、淫秽色情、虚假、侮辱、诽谤、恐吓或骚扰、侵犯他人版权或人身权或其他合法权益等违法或有违社会公序良俗的内容。</p>
            <p>6、仁石科技保留为维护系统升级而短暂停止服务的权利，在暂停服务之前，仁石科技将通过网站予以公告。</p>
            <p>7、如果合同被终止（除由于违反合同协议致使合同终止之外），并且您此时有这项要求的话， 仁石科技可应您要求在协议终止后的30日之内，向您提供一个关于数据信息的文件或获取文件的方法。 在协议终止90天后（或根据客户要求可以提前），系统自动删除这些数据信息。</p>
            <p>8、仁石科技可以根据中国法律法规的调整、 行政执法机关的命令和社会伦理道德的变化相应调整易对账服务的审核标准，客户不得以类似“以前曾通过仁石科技审核”的理由要求仁石科技继续审核通过。</p>
            <p>9、服务期限内，仁石科技将为您提供如下客户服务：</p>
            <h3>(1）仁石科技为付费用户提供7×24小时售后故障服务，并为付费用户提供有效的联系方式并保证付费用户能够联系到故障联系人。故障联系人在明确故障后及时进行反馈；</h3>
            <h3>(2）仁石科技提供7*24小时的在线服务系统，解答客户在使用中的问题。</h3>
            <p>10、仁石科技承诺应严格遵守客户的数据保密义务。明确客户数据的所有权属于客户本身。</p>
            <h2>六、保密责任</h2>
            <p>1、保密资料指由一方向另一方披露的所有技术及非技术信息(包括但不限于产品资料，产品计划，价格， 财务及营销规划，业务战略，客户信息，客户数据，研发，软件硬件，API应用数据接口，技术说明，设计，特殊公式，特殊算法等)。</p>
            <p>2、本服务条款任何一方同意对获悉的对方之上述保密资料予以保密，并严格限制接触上述保密信息的员工遵守本条之保密义务。 除非国家机关依法强制要求或上述保密资料已经进入公有领域外，接受保密资料的一方不得对外披露。</p>
            <p>3、本服务条款双方明确认可各自用户信息和业务数据等是各自的重要资产及重点保密信息。本服务条款双方同意 尽最大的努力保护上述保密信息等不被披露。一旦发现有上述保密信息泄露事件，双方应合作采取一切合理措施避免或者减轻损害后果的产生。</p>
            <p>4、本条款不因本服务条款的终止而失效。</p>
            <h2>七、违约责任</h2>
            <p>1、 本服务条款任何一方违约均须依法承担违约责任。</p>
            <p>2、 您理解，鉴于计算机、互联网的特殊性，下述情况不属于仁石科技违约：</p>
            <h3>1）仁石科技在进行易对账服务配置、维护、升级时，需要短时间中断服务；</h3>
            <h3>2）依云公司提供的服务涉及到互联网及相关信息等服务，可能会受到Internet不稳定因素的影响。 因此服务存在因上述不可抗力、计算机病毒或黑客攻击、系统不稳定、 用户所在位置、用户关机、通信网络、Internet等原因等造成您访问易对账服务速度下降或无法使用；</h3>
            <p>3、由于您的故意或过失导致遭受损失的，仁石科技不承担任何责任。</p>
            <p>4、如因仁石科技原因，造成您连续72小时不能正常使用服务的，您可以终止服务，但非仁石科技控制之内的原因引起的除外。</p>
            <p>5、如果仁石科技违反服务条款规定的义务，给您造成损失的，赔偿金的最高限额为您有关“易 对账服务”向仁石科技首次提出赔偿主张时最近一次续费实际支付的“易对账服务”服务费。客户未续费的，以首次支付的“服务费”为限额。</p>
            <p>6、在任何情况下，仁石科技对本服务条款所承担的违约赔偿责任总额不超过违约服务对应之服务费总额。</p>
            <h2>八、争议解决</h2>
            <p>1、 本合同的生效、解释、执行、管辖、争议的解决均适用中华人民共和国法律。</p>
            <p>2、 因本合同引起的或与本合同有关的任何争议，双方可友好协商解决；协商不成，可将争议提交中国国际经济贸易仲裁委员会华南分会仲裁。</p>
            <h2>九、服务期限与终止</h2>
            <p>1、如果你与仁石科技已经签署“易对账服务销售合同”，服务期限由该合同约定；如果没有，自您易对账服务 创建成功之日起（而非您获取易对账的管理员登录号和密码之日起）计算，并以您所缴纳的服务费款项数额为依据确认服务期限。
                发生下列情形，合同提前终止：</p>
            <h3>（1）双方协商一致提前终止的；</h3>
            <h3>（2）您严重违反本服务条款（包括但不限于a.您未按照协议约定履行付款义务，及/或b.您严重违反法律规定等），仁石科技有权提前终止服务，并不退还您已经支付的费用；</h3>
            <h3>（3）您理解并充分认可，虽然仁石科技已经建立（并将根据技术的发展不断完善）必要的技术措施来防御包括计算机病毒、网络入侵和攻击破坏（包括但不限于DDOS）等危害网络安全事项或行为（以下统称该等行为），但鉴于网络安全技术的局限性、 相对性以及该等行为的不可预见性，如因此终止服务的，仁石科技将按照实际提供服务月份计算（不足一个月的按一个月计）服务费，将剩余款项（如有）返还；</h3>
            <h3>（4）如因仁石科技原因，造成您连续72小时不能正常使用服务的，您可以终止服务，仁石科技将按照实际提供服务月份计算（不足一个月的按一个月计）服务费，将剩余款项（如有）返还。</h3>
            <h2>十、特别声明</h2>
            <p>1、仁石科技郑重提示：为享有高效优质的服务，请您务必仔细阅读并确保完全理解www.yiduizhang.com网站下的 《易对账服务条款》，www.yiduizhang.com的服务条款是最新版本。您完全理解并认可明白，www.yiduizhang.com有“易对账服务”服务的最新版本， 任何人士和机构提供的文件（包括但不限于本合同）中有关“易对账服务”服务描述与该服务条款矛盾的，以该服务条款为准。</p>
            <p>2、仁石科技有权以提前30天在www.yiduizhang.com上公布、或给您发网站内通知或书面通知的方式将本服务条款的权利义务全部或者部分转移给依云公司的关联公司。</p>
            <p>3、如果任何条款在性质上或其他方面理应地在此协议终止时继续存在， 那么应视为继续存在的条款，这些条款包括但不局限于保证条款、保密条款、知识产权条款、法律适用及争议解决条款。</p>
        </div>
        <span class="shark_contant_close"></span>
    </div>

    <div class="shark_heard"><img src="/wechat/image/heard_img1.png" alt=""></div>

    <div class="mui-content" style="background: transparent; margin-top: 30px;">
        <div class="mui-content-padded related_form_content">
            <form id="signForm" class="mui-input-group related_form">
                <p style="color: #fff;">邀请人：${inviterName}</p>

                <div class="mui-input-row related_form_row">
                    <input type="text" class="mui-input-clear" id="realName" name="realName" placeholder="请输入真实姓名">
                </div>

                <div class="mui-input-row related_form_row">
                    <input type="text" class="mui-input-clear" id="userId" name="userId" value="" placeholder="请输入手机号">
                </div>

                <div class="mui-input-row related_form_row">
                    <input type="password" class="mui-input-password" id="password" name="password" placeholder="请设置6-20位的密码">
                </div>

                <div class="mui-input-row related_form_codes related_form_prov_undline">
                    <input type="text" id="code" name="code" class="mui-input" placeholder="请输入验证码">
                    <div><button id="countdown" style="background: #ffb900; color: #fff; border: 1px solid #ffb900;">获取短信验证码</button></div>
                </div>
                <div class="related_form_check related_form_prov_undline" style="color: #fff;">
                    <input value="Item 1" type="checkbox" checked id="related_form_prov_undline_input_check">
                    <label for="related_form_prov_undline_input_check">同意</label>
                    <a class="yonghuyinsi" onclick="sharkContant('1')">《用户隐私保护》</a>与
                    <a class="fuwutiaokuan" onclick="sharkContant('2')">《服务条款协议》</a>
                </div>
                <div class="mui-button-row related_form_sub">
                    <button type="button" class="mui-btn mui-btn-primary" id="next_tap" style="background: #ffb900; border: 1px solid #ffb900; box-shadow: 4px 8px 2px #b23945; font-size: 18px">立即注册</button>
                </div>
            </form>
            <%--<a href="account-relating.html" style="color: #fff;">有账号？立即登录</a>--%>
        </div>
    </div>
    <p class="copyright_text">Copyright@2016 上海仁石科技版权所有 <br> 沪ICP备16005067</p>
</div>
<script src="/resources/common/global-config.js?v=051236a6d6"></script>
<script src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
<script src="/wechat/js/form.js?v=595e2db8af"></script>
<script>
    //同意选中监听
    $("#related_form_prov_undline_input_check").on("click",function(data){
        if($(this).prop("checked")){
            $("#next_tap").removeAttr("disabled");
        }else{
            $("#next_tap").attr("disabled","disabled");
        }
    });

    $("#countdown").click(function(){
        var phone = $("input[name='userId']").val();
        if(phone ==undefined || phone == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("请输入手机号").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }
        //调用倒计时插件
        $(this).countdown();
        $.get("/tool/sendVerCode",{phone:phone},function (data) {});
    });

    $("#next_tap").click(function(){
        $(_this).html("").addClass("lodingBtn").attr("disabled","true");
        var _this = $(this);
        var code = $("input[name='code']").val();
        var userId = $("#userId").val();
        var realName = $("#realName").val();
        var password = $("#password").val();

        /*if($("#related_form_prov_undline_input_check").prop("checked")){
            $("<div class='tips_contants'>").fadeIn(250).html("").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }*/


        if(userId == undefined || userId == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("请填写手机号").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }
        if(realName == undefined || realName == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("请填写用户名").delay(3000).fadeOut(250).appendTo('body');
            return false;

        }
        if(password == undefined || password == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("请填写密码").delay(3000).fadeOut(250).appendTo('body');
            return false;

        }
        if(code == undefined || code == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("短信验证码不能为空").delay(3000).fadeOut(250).appendTo('body');
            return false;
        };
        $.get("/tool/verificateCode",{code:code},function (data) {
            if(data=="1"){
                $.post("<c:url value='/invite/normal/signUp'/>",$("#signForm").serialize(),function(callback){

                    if(callback.state=="1"){
                        $("#next_tap").html("注册成功");
                        <%--setTimeout(function(){--%>
                            <%--window.location.href="<c:url value='/invite/normal/detailIndustryPage'/>"--%>
                        <%--},1000);--%>
                        setTimeout(function(){
                            var system = {
                                win: false,
                                mac: false,
                                xll: false,
                                ipad:false
                            };
                            var p = navigator.platform;

                            system.win = p.indexOf("Win") == 0;
                            system.mac = p.indexOf("Mac") == 0;
                            system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
                            if(system.win||system.mac||system.xll){
                                window.location.href= "/invite/com/success";     //邀请公司注册成功
                            }else{
                                window.location.href="/invite/com/success";   //邀请公司注册成功
                            }
                        },3000);

                    }else{
                        $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(3000).fadeOut(250).appendTo('body');
                        $(_this).html("立即注册").removeClass("lodingBtn").removeAttr("disabled","true");
                    }
                })
            }else{
                $("<div class='tips_contants'>").fadeIn(250).html("验证码错误").delay(3000).fadeOut(250).appendTo('body');
                $(_this).html("立即注册").removeClass("lodingBtn").removeAttr("disabled","true");

            }
        });
    });

    function sharkContant(val){
        switch (val){
            case "1":
                $(".shark_contant_contant").fadeIn();
                $("#yonghuyinsi").fadeIn();
                break;
            case "2":
                $(".shark_contant_contant").fadeIn();
                $("#fuwutiaokuan").fadeIn();
                break;
        }
    }

    $(".shark_contant_close").click(function(){
        $(".shark_contant_contant").fadeOut();
        $("#fuwutiaokuan,#yonghuyinsi").fadeOut();
    })

</script>
</body>
</html>
