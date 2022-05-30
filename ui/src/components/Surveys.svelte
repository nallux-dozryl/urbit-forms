<script>
  export let title;
  export let author;
</script>

  <div class="survey">
    <div class="offset"></div>
    <button class="title button">
      <p class="survey-title">{title}</p>
      <p>created by {(author === window.ship) ? "me" : "~" + author}</p>
    </button>
    <div class="settings">
      {#if author === window.ship}
      <button class="setting button">
        ⚙
      </button>
      {/if}
      <button class="setting button">
        ⮻
      </button>
      <button class="setting button">
        🗑
      </button>
    </div>
  </div>

<style>

  p {
    margin: 0;
  }

  .survey {
    display: flex;
    width: 100%;
    background: white;
    border: 2px solid black;
    padding: 6px 0 6px 0;
    margin-bottom: 4px;
  }

  .survey:hover {
    background: black;
    color: white;
  }

  .survey-title {
    font-size: 1.333em;
  }

  .button {
    background: none;
    border: none;
    color: inherit;
  }

  .offset {
    flex: 1;
  }

  .title {
    flex: 9;
  }

  .settings {
    flex: 1;
    display: flex;
    flex-direction: column;
    text-align: right;
  }

  .setting {
    flex: 1
  }

  .setting:hover {
    color: grey;
  }
  
</style>
