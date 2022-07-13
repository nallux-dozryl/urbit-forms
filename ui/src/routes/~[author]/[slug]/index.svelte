<script>

  import { onMount } from 'svelte'
  import { active, isAdmin, getForm, getSubmissions } from '../../../UrbitStore'
  import Buttons from '../../../FormHeader/Buttons.svelte'
  import Info from '../../../FormHeader/Info.svelte'
  import Section from '../../../FormBody/Section.svelte'
  import Admin from '../../../FormBody/Admin.svelte'

  import { page } from '$app/stores';

  const url = $page.url;
  let ship;
  active.set(null)

  let arr = $page.url.pathname.split('/') 

  onMount(()=> {
    getForm(window.ship, arr[3] + "/" + arr[4])
    ship = window.ship
  })


</script>
{#if $active}
  {#if $isAdmin}
    <Buttons/>
    <Admin />
  {:else}
    <div>
    <Buttons/>
      <Info />
      <Section />
    </div>
  {/if}
{/if}
