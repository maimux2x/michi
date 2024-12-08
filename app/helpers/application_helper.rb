module ApplicationHelper
    def default_meta_tags
    {
      site: "michi",
      title: "道 未知 充ち！",
      reverse: true,
      charset: "utf-8",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        type: "website",
        url: request.original_url,
        image: image_url("/IMG_0025.PNG"),
        local: "ja-JP"
      },
      twitter: {
        site: "@",
        image: image_url("/IMG_0025.PNG")
      }
    }
  end
end
