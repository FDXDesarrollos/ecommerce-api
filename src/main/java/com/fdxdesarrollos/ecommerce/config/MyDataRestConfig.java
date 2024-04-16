package com.fdxdesarrollos.ecommerce.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

import com.fdxdesarrollos.ecommerce.entity.Product;
import com.fdxdesarrollos.ecommerce.entity.ProductCategory;

import jakarta.persistence.EntityManager;
import jakarta.persistence.metamodel.EntityType;


@Configuration
public class MyDataRestConfig implements RepositoryRestConfigurer {
	//@Autowired
	private EntityManager entityManager;
	
	
	public MyDataRestConfig(EntityManager theEntityManager) {
		this.entityManager = theEntityManager;
	}
	
	@Override
	public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {
		HttpMethod[] theUnsupportedActions = {HttpMethod.POST, HttpMethod.PUT, HttpMethod.DELETE};
		
		// disable HTTP methods for Product: POST, PUT and DELETE
		config.getExposureConfiguration()
		      .forDomainType(Product.class)
		      .withItemExposure((metadata, httpMethods) -> httpMethods.disable(theUnsupportedActions))
		      .withCollectionExposure((metadata, httpMethods) -> httpMethods.disable(theUnsupportedActions));
		
		// disable HTTP methods for ProductCategory: POST, PUT and DELETE
		config.getExposureConfiguration()
		      .forDomainType(ProductCategory.class)
		      .withItemExposure((metadata, httpMethods) -> httpMethods.disable(theUnsupportedActions))
		      .withCollectionExposure((metadata, httpMethods) -> httpMethods.disable(theUnsupportedActions));
		
		exposeIds(config);
	}

	private void exposeIds(RepositoryRestConfiguration config) {
		// Get a list of all entity classes from the entity manager
		Set <EntityType<?>> entities = entityManager.getMetamodel().getEntities();
		
		// Create an array of the entity types
		List<Class> entityClasses = new ArrayList<>();
		
		// Get the entity types for the entities
		for (EntityType tempEntityType : entities) {
			entityClasses.add(tempEntityType.getJavaType());
		}
		
		// Expose the entity ids for the array of entity/domain types
		Class[] domainTypes = entityClasses.toArray(new Class[0]);
		config.exposeIdsFor(domainTypes);
	}
	
}
