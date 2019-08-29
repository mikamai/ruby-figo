# frozen_string_literal: true

module Figo
  # List complete catalog (user auth)
  # The real catalog contains thousands of entries, so expect the call to cause some traffic and delay.
  #
  # @param q [String] Two-letter country code. Show only resources within this country. Country code is case-insensitve.
  # @param country [String] Query for the entire catalog. Will match banks on domestic bank code, BIC, name or figo-ID. Will match services based on name or figo-ID. Only exact matches are returned.
  # @return [Catalog] modified bank object returned by server
  def list_complete_catalog_user_auth(q:, country:)
    list_complete_catalog(q, country, '/rest/catalog')
  end

  # List complete catalog (client_auth)
  # The real catalog contains thousands of entries, so expect the call to cause some traffic and delay.
  # @note: The client has to have the accounts=rw scope in order to retrieve the catalog.
  # @param q [String] Two-letter country code. Show only resources within this country. Country code is case-insensitve.
  # @param country [String] Query for the entire catalog. Will match banks on domestic bank code, BIC, name or figo-ID. Will match services based on name or figo-ID. Only exact matches are returned.
  # @return [Catalog] modified bank object returned by server
  def list_complete_catalog_client_auth(q:, country:)
    list_complete_catalog(q, country, '/catalog')
  end

  private

  def list_complete_catalog(q, country, path)
    q_param = !q.nil? && !q.empty? ? "?q=#{q}" : nil
    country_param = nil
    if !country.nil? && !country.empty?
      country_param = q_param ? "&country=#{country}" : "?country=#{country}"
    end

    query_api_object Catalog, [path, q_param, country_param].join
  end
end
