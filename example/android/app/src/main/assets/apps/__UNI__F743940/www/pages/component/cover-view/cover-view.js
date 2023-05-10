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


(()=>{var a=Object.create;var l=Object.defineProperty;var v=Object.getOwnPropertyDescriptor;var A=Object.getOwnPropertyNames;var _=Object.getPrototypeOf,w=Object.prototype.hasOwnProperty;var d=(e,o)=>()=>(o||e((o={exports:{}}).exports,o),o.exports);var g=(e,o,t,c)=>{if(o&&typeof o=="object"||typeof o=="function")for(let r of A(o))!w.call(e,r)&&r!==t&&l(e,r,{get:()=>o[r],enumerable:!(c=v(o,r))||c.enumerable});return e};var f=(e,o,t)=>(t=e!=null?a(_(e)):{},g(o||!e||!e.__esModule?l(t,"default",{value:e,enumerable:!0}):t,e));var p=d((b,E)=>{E.exports=Vue});var u=f(p());var n=(e,o)=>{let t=e.__vccOpts||e;for(let[c,r]of o)t[c]=r;return t};var m={content:{"":{textAlign:"center",height:"400rpx"}},logo:{"":{height:"200rpx",width:"200rpx",marginTop:"200rpx"}},title:{"":{fontSize:"36rpx",color:"#8f8f94"}},text:{"":{color:"#4CD964",fontFamily:"unincomponents"}},video:{"":{width:"750rpx",height:"400rpx",backgroundColor:"#808080"}},coverview:{"":{position:"absolute",left:0,right:0,top:"0rpx",height:"150rpx",borderWidth:"10rpx",borderColor:"#4CD964"}}},x={data(){return{title:"cover-view",src:"https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/%E7%AC%AC1%E8%AE%B2%EF%BC%88uni-app%E4%BA%A7%E5%93%81%E4%BB%8B%E7%BB%8D%EF%BC%89-%20DCloud%E5%AE%98%E6%96%B9%E8%A7%86%E9%A2%91%E6%95%99%E7%A8%8B@20181126-lite.m4v"}},onLoad(){},methods:{}};function F(e,o,t,c,r,h){return(0,u.openBlock)(),(0,u.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,u.createElementVNode)("view",null,[(0,u.createElementVNode)("u-video",{ref:"video",id:"myVideo",class:"video",src:r.src,controls:"true"},[(0,u.createElementVNode)("u-scalable",{style:{position:"absolute",left:"0",right:"0",top:"0",bottom:"0"}},[(0,u.createElementVNode)("cover-view",{class:"coverview",style:{"overflow-y":"scroll"}},[(0,u.createElementVNode)("u-text",{class:"text"},(0,u.toDisplayString)("\uEA06\uEA0E\uEA0C\uEA0A \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view \u6211\u662F\u53EF\u4EE5\u6EDA\u52A8\u7684cover-view"))])])],8,["src"])])])}var i=n(x,[["render",F],["styles",[m]]]);var s=plus.webview.currentWebview();if(s){let e=parseInt(s.id),o="pages/component/cover-view/cover-view",t={};try{t=JSON.parse(s.__query__)}catch(r){}i.mpType="page";let c=Vue.createPageApp(i,{$store:getApp({allowDefault:!0}).$store,__pageId:e,__pagePath:o,__pageQuery:t});c.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...i.styles||[]])),c.mount("#root")}})();
