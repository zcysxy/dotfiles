module.exports = {
  onWillParseMarkdown: function(markdown) {
    return new Promise((resolve, reject)=> {

      // Example
      // markdown = markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
      // markdown = markdown.replace(/> \[\!.*?\].*/gm, ($0) => $0 + "\n>");

      return resolve(markdown)
    })
  },
  onDidParseMarkdown: function(html, {cheerio}) {
    return new Promise((resolve, reject)=> {

      // Callout test
      html = html.replace(/<blockquote>\n<p>\[\!meta\]-?(<br>)?/gm, ($0) => "<blockquote class=\"meta\"><p>\n");
      html = html.replace(/<blockquote>\n<p>\[\!meta\]-? ([^\s]+)<\/p>/gm, ($0, title) => `<blockquote class=\"meta\">\n<p class=\"callout-title\">${title}</p>`);
      
      // URL encode
      html = html.replace(/https:.*?\/OneDrive\-.*?\/3\-KNWL\/34\-Notes\/Salt\-Box\/.*?\.md/gm, (whole) => encodeURI(encodeURI(`${whole}`)));
      
      // Section embed
      html = html.replace(
        /(<div class=\"embed-start\" section=\"(.*?)\".*\n)(?:.*\n)*?(<h[1-6])(.*?id=\"\2\"(?:.*\n)*?)(\3(?:.*\n)*?)(<div class=\"embed-close\"><\/div>)/gim,
        ($0, embedStart, sectionName, headingStart, sectionContent, sectionAfter, embedClose)=> 
        `<div class="embed">${embedStart}${headingStart}${sectionContent}${embedClose}</div>`
      );

      // Block embed
      html = html.replace(
        /(<div class=\"embed-start\" block=\"(.*?)\".*\n)(?:.*\n)*?(<p>.*?[ \n]\^\2<\/p>)(?:.*\n)*?(<div class=\"embed-close\"><\/div>)/gim,
        ($0, embedStart, blockID, blockContent, embedClose)=> 
        `<div class="embed">${blockContent}</div>`
      );

      // html = html.replace(
      //   /\n\^test<\/p>/gim, ($0) => $0 + "hello"
      // );
      return resolve(html)
    })
  },
  onWillTransformMarkdown: function (markdown) {
        return new Promise((resolve, reject) => {

            markdown = markdown.replace(/^\!\[\[([^\|#\^]+?)\]\]/gm, ($0, filePath)=> `@import "${filePath}.md"`);
            markdown = markdown.replace(/^\!\[\[([^\|#\^]+?)#([^\|#\^]+?)\]\]/gm, ($0, filePath, section)=> `<div class="embed-start" section="${section}"></div>\n@import "${filePath}.md"\n<div class="embed-close"></div>`);
            markdown = markdown.replace(/^\!\[\[([^\|#\^]+?)#\^([^\|#\^]+?)\]\]/gm, ($0, filePath, blockID)=> `<div class="embed-start" block="${blockID}"></div>\n@import "${filePath}.md"\n<div class="embed-close"></div>\n\n`);
            
            return resolve(markdown);
          });
        },
        onDidTransformMarkdown: function (markdown) {
          return new Promise((resolve, reject) => {
          return resolve(markdown);
      });
  }
}