import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-input"
export default class extends Controller {
  static targets = ["searchInput"]

  connect() {
    this.lastQuery = "";
    this.debounceTimeout = null;
  }

  search() {
    const newQuery = this.searchInputTarget.value.trim();

    clearTimeout(this.debounceTimeout);

    this.debounceTimeout = setTimeout(() => {
      if(newQuery.length == 0){
        return;
      }

      if (
        this.lastQuery && newQuery === this.lastQuery
      ) {
        return;
      }

      if (newQuery.length > 2 && newQuery !== this.lastQuery) {
        this.lastQuery = newQuery;
        this.newTermSearch(newQuery);
      }
    }, 2000);
  }

  newTermSearch(query) {
    fetch("/searches", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({ query: query })
    });
  }
}
