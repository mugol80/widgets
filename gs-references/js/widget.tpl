if (!window.Gastronovi) {
	Gastronovi = {};
}

Gastronovi.References = {
	//Private
	xhr: false,
	appAdress: '{Zend_Registry::get("application")->getBaseUrl()}',
	getAdress: '{Zend_Registry::get("application")->getBaseUrl()}references/widget?format=json',
	referencesList: Array(),
	renderList: Array(),
	referencesTotal: 0,
	renderTotal: 0,
	currentPage: 0,
	preLoaderContainer: false,
	mainContainer: false,
	contentContainer: false,
	containerTop: false,
	containerBottom: false,
	paginationContainerTop: false,
	paginationContainerBottom: false,
	filtersContainerTop: false,
	filtersContainerBottom: false,

	companyTypesFullList: Array(
		{ name: '{t}locals.references.widget.companytype.bar.text{/t}', value: 'bar' },
		{ name: '{t}locals.references.widget.companytype.restaurant.text{/t}' , value: 'restaurant' },
		{ name: '{t}locals.references.widget.companytype.hotel.text{/t}' , value: 'hotel' },
		{ name: '{t}locals.references.widget.companytype.snack.text{/t}' , value: 'snack' },
		{ name: '{t}locals.references.widget.companytype.cafe.text{/t}' , value: 'cafe' },
		{ name: '{t}locals.references.widget.companytype.foodtruck.text{/t}' , value: 'foodtruck' },
		{ name: '{t}locals.references.widget.companytype.camping.text{/t}' , value: 'camping' },
		{ name: '{t}locals.references.widget.companytype.franchise.text{/t}' , value: 'franchise' },
		{ name: '{t}locals.references.widget.companytype.other.text{/t}' , value: 'other' },
	),

	//CONFIG
	mainClassName: 'gnReferences',
	cssClassPrefix: 'Gastronovi_References',
	templateName: 'default',
	loadCss: true,
	loadFonts: false,
	showPaginationTop: true,
	showPaginationBottom: true,
	showFiltersTop: true,
	showFiltersBottom: true,
	perPage: 10,

	//SERVER ASK
	gn_reference_image: '',
	gn_sort: '',
	gn_company_type: Array(),
	gn_user_id: Array(),
	gn_country_id: Array(),
	gn_zip: null,
	gn_use: Array(),

	//FILTERS
	filters: {},


	showReferences: function(parent, config = {}) {
		if (!parent || parent == null) {
			console.log('Parent element is required!')
			return {};
		}



		if (config.hasOwnProperty("mainClassName") && typeof config.mainClassName == 'string' && config.cssClassPrefix != '') {
			this.mainClassName = config.mainClassName;
		}

		if (config.hasOwnProperty("cssClassPrefix") && typeof config.cssClassPrefix == 'string' && config.cssClassPrefix != '' ) {
			this.cssClassPrefix = config.cssClassPrefix;
		}

		if (config.hasOwnProperty("templateName") && typeof config.templateName == 'string' ) {
			this.templateName = config.templateName;
		}

		if (config.hasOwnProperty("loadCss") && typeof config.loadCss == 'boolean') {
			this.loadCss = config.loadCss;
		}

		if (config.hasOwnProperty("loadFonts") && typeof config.loadCss == 'boolean') {
			this.loadFonts = config.loadFonts;
		}

		if (config.hasOwnProperty("showPaginationTop") && typeof config.showPaginationTop == 'boolean' ) {
			this.showPaginationTop = config.showPaginationTop
		}

		if (config.hasOwnProperty("showPaginationBottom") && typeof config.showPaginationBottom == 'boolean' ) {
			this.showPaginationBottom = config.showPaginationBottom
		}

		if (config.hasOwnProperty("showFiltersTop") && typeof config.showFiltersTop == 'boolean' ) {
			this.showFiltersTop = config.showFiltersTop
		}

		if (config.hasOwnProperty("showFiltersBottom") && typeof config.showFiltersBottom == 'boolean' ) {
			this.showFiltersBottom = config.showFiltersBottom
		}

		if (config.hasOwnProperty("limit") && typeof config.limit == 'number' ) {
			this.perPage = config.limit
		}


		//SERVER
		if (config.hasOwnProperty("withImageOnly") && typeof config.withImageOnly == 'boolean') {
			this.gn_reference_image = config.withImageOnly
		}

		if (config.hasOwnProperty("sort") && typeof config.sort == 'string' ) {
			this.gn_sort = config.sort
		}

		if (config.hasOwnProperty("companyType") && Array.isArray(config.companyType) ) {
			this.gn_company_type = config.companyType
		}

		if (config.hasOwnProperty("user") && Array.isArray(config.user)) {
			this.gn_user_id = config.user;
		}

        if (config.hasOwnProperty("country") && Array.isArray(config.country)) {
            this.gn_country_id = config.country;
        }

        if (config.hasOwnProperty("zip") && Object.isExtensible(config.zip) ) {
            this.gn_zip = config.zip
        }

		if (config.hasOwnProperty("gn_use") && Array.isArray(config.gn_use)) {
			this.gn_use = config.gn_use;
		}

        if (config.hasOwnProperty("all") && typeof config.all == 'boolean') {
            this.gn_all = config.all;
        }


		//FILTERS
		if (config.hasOwnProperty("filters") && typeof config.filters.isArray == 'undefined' ) {
			this.filters = config.filters
		}




		//DOM fully loaded and parsed
		var $this = this;
		document.addEventListener("DOMContentLoaded", function(event) {
			if ($this._isNode(parent)) {
				$this.parent = parent;
			} else if (typeof parent == 'string') {
				$this.parent = document.getElementById(parent.replace('#',''));
			} else {
				console.log('Parent element must by id [idname || #idname ] or HTMLElement')
				return {};
			}

			$this._addCssToHeader();
			$this._getReferences();
		});


		return this;
	},

	changePage: function(pageNumber = this.currentPage) {
		if (pageNumber == this.currentPage) return;
		if (pageNumber > this.getMaxPageNumberRender()) { pageNumber = this.getMaxPageNumberRender(); }

		this.currentPage = pageNumber;
		this._paginationSetActive();
		this._renderContent();
	},

	getMaxPageNumber: function() {
		return Math.ceil(this.referencesTotal/this.perPage);
	},

	getMaxPageNumberRender: function() {
		return Math.ceil(this.renderTotal/this.perPage);
	},

	getPageItems: function(pageNumber = this.currentPage) {
		return this._referencesListToPage(pageNumber);
	},

	setFilter: function(name, value) {
		this.filters = {
			[name]: value,
		}

		if (value == 'all') {
			delete this.filters[name];
		}

		this._setFilterCompanyTypeActive(value);
		this.refresch();
	},

	refresch: function() {
		this.currentPage = 0;
		this._createRenderList();

		if (this.showPaginationTop) {
			if (this.paginationContainerTop == false && this.containerTop != false) {
				this.paginationContainerTop = this._createElementHtml('div', this.cssClassPrefix+'_paginationTop');
				this.paginationContainerTop.classList.add(this.cssClassPrefix+'_pagination');
				this.containerTop.appendChild(this.paginationContainerTop);
			}

			var topPaginationUl = this.paginationContainerTop.getElementsByTagName('div')[0];
			if (topPaginationUl != undefined) {
				this.paginationContainerTop.removeChild( topPaginationUl );
			}

			if (this.getMaxPageNumberRender() > 1) {
				this._renderPagination(this.paginationContainerTop, this.showPaginationTop);
			}

		}

		if (this.showPaginationBottom) {
			if (this.paginationContainerBottom == false && this.containerBottom != false) {
				this.paginationContainerBottom = this._createElementHtml('div', this.cssClassPrefix+'_paginationBottom');
				this.paginationContainerBottom.classList.add(this.cssClassPrefix+'_pagination');
				this.containerBottom.appendChild(this.paginationContainerBottom);
			}

			var bottomPaginationUl = this.paginationContainerBottom.getElementsByTagName('div')[0];

			if (bottomPaginationUl != undefined) {
				this.paginationContainerBottom.removeChild( bottomPaginationUl );
			}

			if (this.getMaxPageNumberRender() > 1) {
				this._renderPagination(this.paginationContainerBottom, this.showPaginationBottom);
			}
		}



		var content = this.contentContainer.getElementsByTagName('div')[0];

		if (content != 'undefined') {
			this.contentContainer.removeChild( content );
		}

		this._renderContent();
	},

	reset: function() {
		document.body.removeChild(this.mainContainer);
		this._getReferences();
	},


	//RENDER function ------------------------------------

	_render: function() {
		//READ FILTERS AND CREATE LIST TO RENDER
		this._createRenderList();

		//Main contener
		this.mainContainer = this._createElementHtml('div', this.mainClassName);
		this.parent.appendChild(this.mainContainer);

		//Top contener
		if (this.showPaginationTop || this.showFiltersTop) {
			this.containerTop = this._createElementHtml('div', this.cssClassPrefix+'_containerTop');
			this.mainContainer.appendChild(this.containerTop);

			if (this.getMaxPageNumberRender() > 1 && this.showPaginationTop) {
				this.paginationContainerTop = this._createElementHtml('div', this.cssClassPrefix+'_paginationTop');
				this.paginationContainerTop.classList.add(this.cssClassPrefix+'_pagination');
				this.containerTop.appendChild(this.paginationContainerTop);
				this._renderPagination(this.paginationContainerTop, this.showPaginationTop);
			}

			this._renderFilters(this.containerTop, this.showFiltersTop);
		}

		//Contetnt contener
		this.contentContainer = this._createElementHtml('div', this.cssClassPrefix+'_content');
		this.mainContainer.appendChild(this.contentContainer);

		//Bottom contener
		if (this.showPaginationBottom || this.showFiltersBottom) {
			this.containerBottom = this._createElementHtml('div', this.cssClassPrefix+'_containerBottom');
			this.mainContainer.appendChild(this.containerBottom);

			if (this.getMaxPageNumberRender() > 1 && this.showPaginationBottom) {
				this.paginationContainerBottom = this._createElementHtml('div', this.cssClassPrefix+'_paginationBottom');
				this.paginationContainerBottom.classList.add(this.cssClassPrefix+'_pagination');
				this.containerBottom.appendChild(this.paginationContainerBottom);
				this._renderPagination(this.paginationContainerBottom, this.showPaginationBottom );
			}

			this._renderFilters(this.containerBottom, this.showFiltersBottom);
		}

		//Render html
		this._renderContent();
	},


	_renderContent: function() {
		var items = this.getPageItems();
		var html = '<div class="'+this.cssClassPrefix+'_referenceList">';
			//for becouse is faster then foreach
			for (var i = 0; i < items.length; i++) {
			var name = items[i].gn_company_name != false?items[i].gn_company_name:items[i].name;
			var user = items[i].user_id[1] != false?items[i].user_id[1]: '';
			var reference_contact = items[i].gn_reference_contact != false?items[i].gn_reference_contact: '';
			var company_type = items[i].gn_company_type != false?items[i].gn_company_type: '';
			var reference_text = items[i].gn_reference_text != false?items[i].gn_reference_text: '';
			var website = items[i].website != false?items[i].website: '';
			var link = items[i].gn_reference_link != false ? items[i].gn_reference_link : '#';
            var companyTypeLabel = null;

            if (company_type) {
                for (var typeIndex = 0; typeIndex < Gastronovi.References.companyTypesFullList.length; typeIndex++) {
                    if (Gastronovi.References.companyTypesFullList[typeIndex].value == company_type) {
                        companyTypeLabel = Gastronovi.References.companyTypesFullList[typeIndex].name;
                    }
                }
            }

            var location = '';
			if (companyTypeLabel) {
				location += companyTypeLabel;
			}

			if (items[i].city) {
				if (location.length) location += ', ';
                location += items[i].city;
			}

			html += '<div class="'+this.cssClassPrefix+'_listItem">';
				html += '<div class="'+this.cssClassPrefix+'_itemConteiner">';
					html += '<a href="'+link+'" target="_blank" class="'+this.cssClassPrefix+'_fullInfoLink"></a>';
					html += '<div class="'+this.cssClassPrefix+'_info">';
						html += '<div class="'+this.cssClassPrefix+'_section">';
							html += '<div class="'+this.cssClassPrefix+'_line"></div>';
							html += '<div class="'+this.cssClassPrefix+'_title">'+name+'</div>';

							if (location.length) {
                                html += '<div class="' + this.cssClassPrefix + '_desc">' + location + '</div>';
                            }

							html += '<div class="'+this.cssClassPrefix+'_desc">'+reference_contact+'</div>';
							html += '<div class="'+this.cssClassPrefix+'_text">'+reference_text+'</div>';
							html += '</div>';
						html += '</div>';

					html += '<div class="'+this.cssClassPrefix+'_details">';
						html += '<div class="'+this.cssClassPrefix+'_section">';
							html += '<div class="'+this.cssClassPrefix+'_column '+this.cssClassPrefix+'_website">';
								if(website != '') {
								html += '<div class="title">Webseite</div>';
								html += '<div><strong><a href="'+website+'" target="_blank"><i class="icon-forward"></i>Webseite anzeigen</a></strong></div>';
								}
								html += '</div>';

							html += '<div class="'+this.cssClassPrefix+'_column '+this.cssClassPrefix+'_client">';
								html += '<div class="title">Kunde</div>';
								html += '<div><strong>'+items[i].name+'</strong></div>';
								html += '</div>';
							html += '</div>';
						html += '</div>';

					html += '<div class="'+this.cssClassPrefix+'_imgContainer">';
						html += '<div class="'+this.cssClassPrefix+'_mask"></div>';
						if  (this.gn_reference_image == false) {
						if (items[i].gn_reference_image != false) {
						html += '<img src="data:image/jpeg;base64,'+items[i].gn_reference_image+'" alt="'+name+'">';
						} else {
						html += '<img src="{Zend_Registry::get("application")->getBaseUrl()}images/gnreferences/default.jpg" alt="'+name+'">';
						}
						}
						html += '</div>';
					html += '</div>';
				html += '</div>';
			}
			html += '</div>';

		this.contentContainer.innerHTML = html;
	},

	_renderPagination: function(place, isRender) {
		if ( (!place  || !isRender) || this.getMaxPageNumberRender() < 2 ) return false;
		var ul = this._createElementHtml('div', this.cssClassPrefix+'_paginationList');
		place.appendChild(ul);

		for (var i = 0; i < this.getMaxPageNumberRender(); i++) {
			var className = i==this.currentPage?this.cssClassPrefix+'_active':'';
			var li = this._createElementHtml('div', this.cssClassPrefix+'_listItem');
			if (className != '') { li.classList.add(className); }
			ul.appendChild(li);

			var a = this._createElementHtml('a');
			a.setAttribute('href', '#');
			a.setAttribute('data-pagenumber', i);
			a.innerHTML = '<span>'+(i+1)+'</span>';
			li.appendChild(a);
			this._paginationAddEventListener(a);
		}
	},


	_renderFilters: function(place, isRender) {
		if (!place || !isRender) return false;
		var div = this._createElementHtml('div', this.cssClassPrefix+'_filters');
		place.appendChild(div);

		var select = this._createElementHtml('select', this.cssClassPrefix+'_companyType');
		select.setAttribute("name", this.cssClassPrefix+'_companyType');
		div.appendChild(select);

		var getFiltersCompanyTypeElements = this._getFiltersCompanyTypeElements();

		for (var i = 0; i < getFiltersCompanyTypeElements.length; i++) {
			var option = document.createElement("option");
			if ( this.filters.hasOwnProperty("companyType") && getFiltersCompanyTypeElements[i].value == this.filters.companyType)
			{
				option.setAttribute("selected", "selected");
			}

			option.setAttribute("value", getFiltersCompanyTypeElements[i].value);
			option.innerHTML = getFiltersCompanyTypeElements[i].name;
			select.appendChild(option);
		}

		this._selectAddEventListener(select);
	},

	//HELPER function ------------------------------------

	_createRenderList: function() {
		var rL = this.referencesList;
		var renderList =  Array();

		if (this.filters.hasOwnProperty("companyType") ) {
			for (var i = 0; i < rL.length; i++) {
				if (this.filters.companyType == rL[i].gn_company_type || (this.filters.companyType == 'other' && rL[i].gn_company_type == false )) {
					renderList.push(rL[i]);
				}
			}
		} else {
			renderList = rL;
		}

		this.renderList = renderList;
		this.renderTotal = renderList.length;
		return renderList;
	},


	_paginationAddEventListener: function(element) {
		$this = this;
		element.removeEventListener('click', this._paginationClick);
		element.addEventListener('click', function(e) {
			$this._paginationClick(e, element);
		});
	},

	_paginationClick: function(e, element) {
		e.preventDefault();
		e.stopPropagation();
		var pageNumber = element.getAttribute('data-pagenumber');
		if (pageNumber == null) return;
		this.changePage(pageNumber);
	},

	_paginationSetActive: function() {
		var className = this.cssClassPrefix+'_listItem';
		var classNameActive = this.cssClassPrefix+'_active';
		if (this.paginationContainerTop != false) {
			var li = this.paginationContainerTop.getElementsByClassName(className);
			for (var i = 0; i < li.length; i++) {
				this._removeClass( classNameActive, li[i] );

				var pageNumber = li[i].getElementsByTagName('a')[0].getAttribute('data-pagenumber');
				if (pageNumber == this.currentPage) {
					this._addClass( classNameActive, li[i] );
				}

			}
		}

		if (this.paginationContainerBottom != false) {
			var li = this.paginationContainerBottom.getElementsByClassName(className);
			for (var i = 0; i < li.length; i++) {
				this._removeClass( classNameActive, li[i] );

				var pageNumber = li[i].getElementsByTagName('a')[0].getAttribute('data-pagenumber');
				if (pageNumber == this.currentPage) {
					this._addClass( classNameActive, li[i] );
				}
			}
		}
	},

	_addClass: function( classname, element ) {
		var cn = element.className;
		//test for existance
		if( cn.indexOf( classname ) != -1 ) {
			console.log('xxx');
			return;
		}
		//add a space if the element already has class
		if( cn != '' ) {
			classname = ' '+classname;
		}
		element.className = cn+classname;
	},

	_removeClass: function( classname, element ) {
		var cn = element.className;
		var rxp = new RegExp( classname, "g" );
		cn = cn.replace( rxp, '' );
		element.className = cn;
	},

	_createElementHtml: function(tagName = 'div', className='', id='') {
		var element = document.createElement(tagName);
		if (className != '') { element.classList.add(className); }
		if (id != '') { element.id = id; }
		return element;
	},

	_referencesListToPage: function(pageNumber = this.currentPage) {
		var rL = this.renderList;
		var start = pageNumber * this.perPage;
		var end = start + this.perPage;
		var page = Array();

		for (var i = start; i < end; i++) {
			if (rL[i] == undefined) continue;
				page.push(rL[i]);
			}
		return page;
	},

	//Returns true if it is a DOM node
	_isNode: function(o){
		return (
			typeof Node === "object" ? o instanceof Node :
			o && typeof o === "object" && typeof o.nodeType === "number" && typeof o.nodeName==="string"
		);
	},

	//Returns true if it is a DOM element
	_isElement: function(o){
		return (
			typeof HTMLElement === "object" ? o instanceof HTMLElement : //DOM2
			o && typeof o === "object" && o !== null && o.nodeType === 1 && typeof o.nodeName==="string"
		);
	},


//FILTERS function ------------------------------------

	_getFiltersCompanyTypeElements: function() {
		var elements = Array({ name: '{t}locals.references.widget.companytype.all.text{/t}', value: 'all' });
		var avTypes = this._availableCompanyTypes();
		var fL = this.companyTypesFullList;

		for (var i = 0; i < fL.length; i++) {
			if (avTypes.includes(fL[i].value)) {
				elements.push(fL[i]);
			}
		}

		return elements;
	},

	_availableCompanyTypes: function() {
		var referencesList = this.referencesList;
		var elements = Array();

		for (var i = 0; i < referencesList.length; i++) {

		if (!elements.includes(referencesList[i].gn_company_type)) {
			if (referencesList[i].gn_company_type == false) {
				if (!elements.includes('other')) { elements.push('other'); }
					//TODO
				} else {
				elements.push(referencesList[i].gn_company_type);
				}
			}
		}
		return elements;
	},

	_setFilter: function(e, element) {
		e.preventDefault();
		e.stopPropagation();

		var name = element.getAttribute('name');
		name = name.substring((this.cssClassPrefix.length + 1))
		var value = element.value;

		this.setFilter(name, value);

	},

	_selectAddEventListener: function(element) {
		var $this = this;
		element.removeEventListener('change', this._setFilter);
		element.addEventListener('change', function(e) {
			$this._setFilter(e, element);
		});
	},

	_setFilterCompanyTypeActive: function(value) {
		if (this.containerTop != false) {
			var companyTypeTop = this.containerTop.getElementsByClassName(this.cssClassPrefix+'_companyType')[0];
			if (companyTypeTop != undefined) {
				companyTypeTop.value = value;
			}
		}

		if (this.containerBottom != false) {
			var companyTypeBottom = this.containerBottom.getElementsByClassName(this.cssClassPrefix+'_companyType')[0];
			if (companyTypeBottom != undefined) {
				companyTypeBottom.value = value;
			}
		}
	},


	//CSS function ------------------------------------

	_addCssToHeader: function() {
		if (!this.loadCss) { return; }

		var head = document.getElementsByTagName('head')[0];
		var classPrefix = this.cssClassPrefix != '' ? 'classPrefix='+this.cssClassPrefix : '';
		var className = this.mainClassName != '' ? 'className='+this.mainClassName : '';
		var templateName = this.templateName != '' ? this.templateName : '';
		var loadFonts = this.loadFonts != '' ? 'loadFonts='+this.loadFonts : '';

		//TEMPLATE CSS
		if (templateName != '' && !document.getElementById(this.cssClassPrefix+'_'+templateName+'_css')) {
			var link = document.createElement('link');
			link.id = this.cssClassPrefix+'_'+templateName+'_css';
			link.rel = 'stylesheet';
			link.type = 'text/css';
			link.href = '{Zend_Registry::get("application")->getBaseUrl()}references/css/'+templateName+'?'+className+'&'+classPrefix;
			link.media = 'all';
			head.insertAdjacentElement('afterbegin', link);
		}

		//MAIN CSS
		if (!document.getElementById(this.cssClassPrefix+'_main_css')) {
			var link = document.createElement('link');
			link.id = this.cssClassPrefix+'_main_css';
			link.rel = 'stylesheet';
			link.type = 'text/css';
			link.href = '{Zend_Registry::get("application")->getBaseUrl()}references/css?'+className+'&'+classPrefix+'&'+loadFonts;
			link.media = 'all';
			head.insertAdjacentElement('afterbegin', link);
		}
	},


	//XHR function ------------------------------------

	_getReferences: function() {
		var $this = this;
		if (window.XMLHttpRequest) { this.xhr = new XMLHttpRequest() };

		if (!this.xhr) {
			console.log('XMLHttpRequest not supported.');
			return;
		};

		if (!("withCredentials" in this.xhr)) {
			// CORS not supported.
			console.log('CORS not supported..');
			return;
		}

		this._abortXhr();

		//Preloader
		this.preLoaderContainer = this._createElementHtml('div', this.cssClassPrefix+'_preloader');
		this.parent.appendChild(this.preLoaderContainer);

		var preLoaderContainer = this.parent.getElementsByTagName('div')[0];

		var preLoader = '<div class="loader">';
				preLoader += '<div class="square" ></div>';
				preLoader += '<div class="square"></div>';
				preLoader += '<div class="square last"></div>';
				preLoader += '<div class="square clear"></div>';
				preLoader += '<div class="square"></div>';
				preLoader += '<div class="square last"></div>';
				preLoader += '<div class="square clear"></div>';
				preLoader += '<div class="square "></div>';
				preLoader += '<div class="square last"></div>';
			preLoader += '</div>';

		this.preLoaderContainer.innerHTML = preLoader;

		this.xhr.open("POST", this.getAdress, true);

		this.xhr.addEventListener('load', function() {
			if (preLoaderContainer != undefined) {
				$this.parent.removeChild( preLoaderContainer );
			}
			if ($this.xhr.readyState == 4 && $this.xhr.status == 200) {
				var dataBack = JSON.parse($this.xhr.responseText);
				if (dataBack.hasOwnProperty("success") && dataBack.success == true && dataBack.hasOwnProperty("References") ) {
				$this.referencesList = dataBack.References;
				$this.referencesTotal = dataBack.total_single.References;
				$this._render();
			}
			} else {
				console.log('Connecting status: ' + this.status)
			}
		});

		this.xhr.addEventListener('error', function(e) {
			if (preLoaderContainer != undefined) {
				document.body.removeChild( preLoaderContainer );
			}
			console.log('Connecting error!');
		});

		this.xhr.addEventListener('abort', function(e) {
			if (preLoaderContainer != undefined) {
				this.parent.removeChild( preLoaderContainer );
			}
			console.log('Connecting abort!');
		});

		//Sending data
		this.xhr.addEventListener('progress', function(e) {
			if (e.lengthComputable) {
				const progress = (e.loaded / e.total) * 100;
				console.log('sending: '+progress)
			}
		});

		//Upload data
		this.xhr.upload.addEventListener('progress', function(e) {
			if (e.lengthComputable) {
				const progress = (e.loaded / e.total) * 100;
				console.log('uploads: '+progress)
			}
		}, false);

		var formData = new FormData();

		formData.append('gn_reference_image', this.gn_reference_image);
		formData.append('gn_sort', this.gn_sort);
		if (this.gn_company_type.length > 0) { formData.append('gn_company_type', JSON.stringify(this.gn_company_type)); }
		if (this.gn_user_id.length > 0) { formData.append('gn_user_id', JSON.stringify(this.gn_user_id)); }
        if (this.gn_country_id.length > 0) { formData.append('gn_country_id', JSON.stringify(this.gn_country_id)); }
        if (this.gn_zip) { formData.append('gn_zip', JSON.stringify(this.gn_zip)); }
		if (this.gn_use.length > 0) { formData.append('gn_use', JSON.stringify(this.gn_use)); }
        if (this.gn_all) { formData.append('gn_all', this.gn_all); }

		for (var key of formData.entries()) {
			console.log(key[0]+': '+key[1]);
		}

		//console.log(this._urlEncodeData(data));

	this.xhr.send(formData);
	},

	_abortXhr: function() {
		if (this.xhr != false) this.xhr.abort();
	},

	_urlEncodeData: function(data) {
		var params = new URLSearchParams();
		for (var key in data) {
			params.append(key, data[key]);
		}
		return params.toString();
	},


};
