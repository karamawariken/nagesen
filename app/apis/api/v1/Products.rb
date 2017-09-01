module API
  module V1
    class Products < Grape::API
      resource :products do

        # GET /api/v1/products/serach
        desc 'Return all products.'
        get '/search', jbuilder: 'api/v1/products/search'do
          authenticate_user!
          @products = Product.find_public_products
          @resoponse = "success"
        end

        # GET /api/v1/products/follow
        desc 'Return current_user follow kids products.'
        get '/follow', jbuilder: 'api/v1/products/search'do
          authenticate_user!
          @products = Product.where(kid_id:Follow.where(followable_id = @current_user.id).pluck(:followable_id))
          @resoponse = "success"
        end

        # GET /api/v1/products/family
        desc 'Return current_user family kids products.'
        get '/family', jbuilder: 'api/v1/products/search'do
          authenticate_user!
          @products = Product.find_public_products
          @resoponse = "success"
        end


        # GET /api/v1/products/show/{:id}
        desc 'Return all products.'
        get '/show/:id', jbuilder: 'api/v1/products/show'do
          @product = Product.find(params[:id])
          @resoponse = "success"
        end

        # POST /api/v1/products/{:kid_id}/create
        desc 'Return create sucess or failure'
        post '/create', jbuilder: 'api/v1/products/create' do
          @params ||= JSON.parse(request.body.read, {:symbolize_names => true})
          @current_kid = Kid.find_by(nick_name: params[:kid_name])
          @product = @current_kid.products.build(
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

        # GET /api/v1/products/draft/{:product_id}
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


        #ユーザが作品をいいねする
        # POST /api/v1/product/like/
        desc 'Return like success or failure'
        params do
        end
        post '/like', jbuilder: 'api/v1/products/like' do
          authenticate_user!
          @params ||= JSON.parse(request.body.read, {:symbolize_names => true})
          @products = Product.find(@params['product_id'])
          if @products.present?
            if @current_user.liked?(@products)
              @current_user.unlike(@products)
            else
              @current_user.likes(@products)
            end
            @response = "success"
          else
            api_error!('Product not found.', "failure", 406,'')
          end
        end

      end
    end
  end
end
