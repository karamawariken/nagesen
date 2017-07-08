module API
  module V1
    class Products < Grape::API
      resource :products do

        # GET /api/v1/products
        desc 'Return all products.'
        get '/search', jbuilder: 'api/v1/products/search'do
          authenticate_user!
          @products = Product.find_public_products
          @resoponse = "success"
        end


        # GET /api/v1/products/{:id}
        desc 'Return all products.'
        get '/show/:id', jbuilder: 'api/v1/products/show'do
          @product = Product.find(params[:id])
          @resoponse = "success"
        end

        # POST /api/v1/products/{:child_id}
        desc 'Return create sucess or failure'
        params do
          requires :child_id, type: Integer, desc: "children id"
        end
        post '/:child_id', jbuilder: 'api/v1/products/create' do
          @params ||= JSON.parse(request.body.read, {:symbolize_names => true})
          #puts @params[:targetImage]
          @current_child = Child.find(params[:child_id])
          @product = @current_child.products.build(
            :title => @params[:title],
            :introduction => @params[:introduction],
            :introduction_voice_link => @params[:introduction_voice_link],
            :image1_link => @params[:image1_link],
            :image2_link => @params[:image2_link],
            :image3_link => @params[:image3_link],
            :state => @params[:state],
            )
          @product.save
          @resoponse = "success"
        end

        # POST /api/v1/products/{:product_id}/photo/{:image_num}
        desc 'Return create sucess or failure'
        params do
          requires :product_id, type: Integer, desc: "product id"
          requires :image_num, type: Integer, desc: "product's photo number"
        end
        post '/:child_id', jbuilder: 'api/v1/products/photo' do
          @current_child = Child.find(params[:child_id])
          json = ActiveSupport::JSON.decode(request.body.read)
          @product = @current_child.products.build(
            :title => json["title"],
            :introduction => json["introduction"],
            :introduction_voice_link => json["introduction_voice_link"],
            :image1_link => json["image1_link"],
            :image2_link => json["image2_link"],
            :image3_link => json["image3_link"],
            :state => json["state"],
            )
          @product.save
          @resoponse = "success"
        end

        # GET /api/v1/products/draft/{:child_id}
        desc 'Return all products.'
        params do
          requires :child_id, type: Integer, desc: "children id"
        end
        get '/draft/:child_id', jbuilder: 'api/v1/products/draft'do
          #authenticate_user!
          @products = Product.find_draft_products
          @resoponse = "success"
        end

        # GET /api/v1/products/draft/{:child_id}
        desc 'Return all products.'
        params do
          requires :product_id, type: Integer, desc: "product id"
        end
        get '/draft/change/:product_id', jbuilder: 'api/v1/products/change'do
          #authenticate_user!
          @products = Product.find(params[:product_id])
          if @products.state == "draft"
            @products.state = "public"
            @products.save
            @resoponse = "success"
          else
             ##エラー処理かく
          end
        end

      end
    end
  end
end
