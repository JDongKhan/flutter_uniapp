"use weex:vue";

if (typeof Promise !== 'undefined' && !Promise.prototype.finally) {
  Promise.prototype.finally = function(callback) {
    const promise = this.constructor
    return this.then(
      value => promise.resolve(callback()).then(() => value),
      reason => promise.resolve(callback()).then(() => {
        throw reason
      })
    )
  }
};

if (typeof uni !== 'undefined' && uni && uni.requireGlobal) {
  const global = uni.requireGlobal()
  ArrayBuffer = global.ArrayBuffer
  Int8Array = global.Int8Array
  Uint8Array = global.Uint8Array
  Uint8ClampedArray = global.Uint8ClampedArray
  Int16Array = global.Int16Array
  Uint16Array = global.Uint16Array
  Int32Array = global.Int32Array
  Uint32Array = global.Uint32Array
  Float32Array = global.Float32Array
  Float64Array = global.Float64Array
  BigInt64Array = global.BigInt64Array
  BigUint64Array = global.BigUint64Array
};


(()=>{var d=Object.create;var c=Object.defineProperty;var _=Object.getOwnPropertyDescriptor;var g=Object.getOwnPropertyNames;var F=Object.getPrototypeOf,v=Object.prototype.hasOwnProperty;var x=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports);var h=(e,t,s,n)=>{if(t&&typeof t=="object"||typeof t=="function")for(let o of g(t))!v.call(e,o)&&o!==s&&c(e,o,{get:()=>t[o],enumerable:!(n=_(t,o))||n.enumerable});return e};var B=(e,t,s)=>(s=e!=null?d(F(e)):{},h(t||!e||!e.__esModule?c(s,"default",{value:e,enumerable:!0}):s,e));var m=x((k,p)=>{p.exports=Vue});var u=B(m());var f=(e,t)=>{let s=e.__vccOpts||e;for(let[n,o]of t)s[n]=o;return s};var y={wrapper:{"":{position:"relative",flex:1,backgroundColor:"rgba(0,0,0,0)"}},list:{"":{position:"absolute",top:0,left:0,right:0,bottom:0,backgroundColor:"rgba(0,0,0,0.7)"}},cell:{"":{paddingTop:"10rpx",paddingRight:0,paddingBottom:"10rpx",paddingLeft:0,flexDirection:"row",flexWrap:"nowrap"}},name:{"":{flex:0,fontSize:"20rpx",marginRight:"20rpx",color:"#FF5A5F"}},content:{"":{flex:1,fontSize:"20rpx",color:"#F4F5F6"}}},b={data(){return{lists:[],interval:null,yourTexts:[{name:"\u5B66\u5458A",content:"\u8001\u5E08\u8BB2\u7684\u771F\u597D"},{name:"\u5B66\u5458B",content:"uni-app\u503C\u5F97\u5B66\u4E60"},{name:"\u5B66\u5458C",content:"\u8001\u5E08\uFF0C\u8FD8\u6709\u5B9E\u6218\u4F8B\u5B50\u5417\uFF1F"},{name:"\u5B66\u5458D",content:"\u8001\u5E08\uFF0C\u8BF7\u95EE\u662F\u4E0D\u662F\u8981\u5148\u5B66\u4F1Avue\u624D\u80FD\u5B66uni-app\uFF1F"},{name:"\u5B66\u5458E",content:"\u53D7\u6559\u4E86\uFF0Cuni-app\u592A\u725B\u4E86"}]}},created(){uni.$on("play-video",e=>{e.status==="open"?this.addItem():this.closeItem()})},beforeDestroy(){uni.$off("play-video"),this.closeItem()},methods:{addItem(){let e=this;e.lists=[{name:"\u5B66\u5458E",content:"\u53D7\u6559\u4E86\uFF0Cuni-app\u592A\u725B\u4E86"}];let t=weex.requireModule("dom");e.interval=setInterval(()=>{e.lists.length>15&&e.lists.unshift(),e.lists.push({name:e.yourTexts[e.lists.length%4].name,content:e.yourTexts[e.lists.length%4].content}),e.lists.length>5&&e.$nextTick(()=>{e.$refs["item"+(e.lists.length-1)]&&t.scrollToElement(e.$refs["item"+(e.lists.length-1)][0])})},3500)},closeItem(){this.interval&&clearInterval(this.interval)}}};function E(e,t,s,n,o,w){return(0,u.openBlock)(),(0,u.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,u.createElementVNode)("div",{class:"wrapper"},[(0,u.createElementVNode)("list",{class:"list"},[((0,u.openBlock)(!0),(0,u.createElementBlock)(u.Fragment,null,(0,u.renderList)(o.lists,(a,i)=>((0,u.openBlock)(),(0,u.createElementBlock)("cell",{key:i,ref_for:!0,ref:"item"+i,class:"cell"},[(0,u.createElementVNode)("u-text",{class:"name"},(0,u.toDisplayString)(a.name)+":",1),(0,u.createElementVNode)("u-text",{class:"content"},(0,u.toDisplayString)(a.content),1)]))),128))])])])}var r=f(b,[["render",E],["styles",[y]]]);var l=plus.webview.currentWebview();if(l){let e=parseInt(l.id),t="pages/API/subnvue/subnvue/video-mask",s={};try{s=JSON.parse(l.__query__)}catch(o){}r.mpType="page";let n=Vue.createPageApp(r,{$store:getApp({allowDefault:!0}).$store,__pageId:e,__pagePath:t,__pageQuery:s});n.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...r.styles||[]])),n.mount("#root")}})();
