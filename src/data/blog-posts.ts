export interface BlogPost {
  id: string;
  slug: string;
  title: string;
}

export const blogPosts: BlogPost[] = [
  {
    id: '1',
    slug: 'post-1',
    title: 'Post 1',
  },
  {
    id: '2',
    slug: 'post-2',
    title: 'Post 2',
  }
];

export const nestedBlogPosts: BlogPost[] = [
  {
    id: '3',
    slug: 'nested-1',
    title: 'Nested 1',
  },
  {
    id: '4',
    slug: 'nested-2',
    title: 'Nested 2',
  }
];

export function getAllBlogPosts(): BlogPost[] {
  return [...blogPosts, ...nestedBlogPosts];
}

export function getBlogPostBySlug(slug: string): BlogPost | undefined {
  return getAllBlogPosts().find(post => post.slug === slug);
}

export function getBlogPostsByCategory(category?: string): BlogPost[] {
  if (!category) return blogPosts;
  return nestedBlogPosts;
}